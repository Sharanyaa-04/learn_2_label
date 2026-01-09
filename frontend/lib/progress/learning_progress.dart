import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
// ignore: avoid_web_libraries_in_flutter
// ignore: uri_does_not_exist
import 'dart:js_util' as js_util;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Tracks points and completed algorithms, synced to Firestore per user.
class LearningProgress extends ChangeNotifier {
  final FirebaseFirestore _db;
  User? _user;

  int _points = 0;
  final Set<String> _completedAlgorithms = {};
  bool _loading = false;
  String? _lastError;
  Timer? _debounceTimer;

  LearningProgress({FirebaseFirestore? db}) : _db = db ?? FirebaseFirestore.instance;

  int get points => _points;
  Set<String> get completedAlgorithms => _completedAlgorithms;
  bool get loading => _loading;
  String? get lastError => _lastError;

  bool isCompleted(String algorithm) => _completedAlgorithms.contains(algorithm);

  /// Attach the current Firebase user. Passing null clears local state.
  Future<void> attachUser(User? user) async {
    _user = user;
    _debounceTimer?.cancel();
    if (user == null) {
      _points = 0;
      _completedAlgorithms.clear();
      _lastError = null;
      notifyListeners();
      return;
    }
    await _loadUserDoc();
  }

  Future<void> _loadUserDoc() async {
    if (_user == null) return;
    _setLoading(true);
    try {
      final ref = _db.collection('users').doc(_user!.uid);
      final snap = await ref.get();
      if (snap.exists) {
        final data = snap.data() ?? {};
        _points = (data['points'] ?? 0) is num ? (data['points'] as num).toInt() : 0;
        _completedAlgorithms
          ..clear()
          ..addAll(List<String>.from(data['completedAlgorithms'] ?? const []));
      } else {
        await ref.set({
          'points': 0,
          'completedAlgorithms': <String>[],
          'createdAt': FieldValue.serverTimestamp(),
        });
        _points = 0;
        _completedAlgorithms.clear();
      }
      _lastError = null;
    } catch (e) {
      _lastError = 'Failed to load progress';
    } finally {
      _setLoading(false);
    }
  }

  /// Award points once per algorithm completion. Uses a transaction to avoid double-awards.
 Future<bool> awardCompletion(String algorithm, {int points = 50}) async {
  if (_user == null) {
    _recordError('Sign in to save progress');
    return false;
  }

  final ref = _db.collection('users').doc(_user!.uid);

  try {
    final result = await _db.runTransaction<bool>((txn) async {
      final snap = await txn.get(ref);
      final data = snap.data() ?? {};

      final completed =
          Set<String>.from(data['completedAlgorithms'] ?? const []);
      var currentPoints =
          (data['points'] ?? 0) is num ? (data['points'] as num).toInt() : 0;

      // ✅ NOT AN ERROR — already completed
      if (completed.contains(algorithm)) {
        return false;
      }

      completed.add(algorithm);
      currentPoints += points;

      txn.set(
        ref,
        {
          'completedAlgorithms': completed.toList(),
          'points': currentPoints,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      return true;
    });

    // ✅ success (either newly awarded OR already completed)
    if (result) {
      _completedAlgorithms.add(algorithm);
      _points += points;
    }

    _lastError = null;
    notifyListeners();

    return true; // 🔥 ALWAYS return true if no exception
  } catch (e, st) {
    final fx = e is FirebaseException ? e : null;
    debugPrint(
        '[points-sync] awardCompletion failed type=${e.runtimeType} code=${fx?.code} message=${fx?.message} error=$e');
    debugPrint('[points-sync] stack: $st');

    if (kIsWeb) {
      _logWebErrorDetails(e, 'awardCompletion');
    }

    _recordError('Could not sync points');
    return false;
  }
}


  /// Add arbitrary points (e.g., bonuses). Debounced and merged into Firestore.
  Future<void> addPoints(int delta) async {
    if (delta == 0) return;
    _points += delta;
    notifyListeners();

    if (_user == null) {
      _recordError('Sign in to save progress');
      return;
    }

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () async {
      final ref = _db.collection('users').doc(_user!.uid);
      try {
        await ref.set({
          'points': FieldValue.increment(delta),
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        _lastError = null;
      } catch (e, st) {
        // TODO: remove verbose points-sync logging after issue is resolved.
        final fx = e is FirebaseException ? e : null;
        debugPrint('[points-sync] addPoints failed type=${e.runtimeType} code=${fx?.code} message=${fx?.message} error=$e');
        debugPrint('[points-sync] stack: $st');
        if (kIsWeb) {
          _logWebErrorDetails(e, 'addPoints');
        }
        _recordError('Could not sync points: $e');
      }
    });
  }

  // Surface JS-side error/stack when running on web to diagnose interop failures.
  void _logWebErrorDetails(Object error, String where) {
    try {
      // Inspect the JS error directly; avoid wrapping with jsify which can drop properties.
      final raw = error;
      final msg = js_util.hasProperty(raw, 'message') ? js_util.getProperty(raw, 'message') : raw.toString();
      final code = js_util.hasProperty(raw, 'code') ? js_util.getProperty(raw, 'code') : null;
      final stack = js_util.hasProperty(raw, 'stack') ? js_util.getProperty(raw, 'stack') : null;
      debugPrint('[points-sync][$where][web] js error=$msg code=$code stack=$stack');
    } catch (err, st) {
      debugPrint('[points-sync][$where][web] failed to inspect js error: $err stack=$st');
    }
  }

  void _recordError(String message) {
    _lastError = message;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}

/// Simple InheritedNotifier to expose [LearningProgress] without extra packages.
class ProgressProvider extends InheritedNotifier<LearningProgress> {
  const ProgressProvider({
    super.key,
    required LearningProgress progress,
    required Widget child,
  }) : super(notifier: progress, child: child);

  static LearningProgress of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<ProgressProvider>();
    assert(provider != null, 'ProgressProvider not found in widget tree');
    return provider!.notifier!;
  }
}
