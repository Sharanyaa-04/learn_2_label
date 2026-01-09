// Minimal Firebase options for the supervised-learning-f2ffd project.
// Generated manually for web; update with `flutterfire configure` for full platform support.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return web; // TODO: replace with Android options via flutterfire configure
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return web; // TODO: replace with Apple options via flutterfire configure
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return web; // TODO: replace with desktop options if needed
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDJI8Z40My-KgPXeL014uzlRMLN3xVWB-Q',
    authDomain: 'supervised-learning-f2ffd.firebaseapp.com',
    projectId: 'supervised-learning-f2ffd',
    storageBucket: 'supervised-learning-f2ffd.firebasestorage.app',
    messagingSenderId: '782896837750',
    appId: '1:782896837750:web:54d08ae8f555f5338a5b57',
    measurementId: 'G-HSHBCKX16P',
  );
}
