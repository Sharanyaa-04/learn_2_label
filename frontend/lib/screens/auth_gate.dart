import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../progress/learning_progress.dart';
import '../theme/theme_controller.dart';
import 'home_screen.dart';
import 'login_screen.dart';

/// Auth gate that waits for auth state and attaches progress to the signed-in user.
class AuthGate extends StatefulWidget {
  final ThemeController themeController;
  const AuthGate({super.key, required this.themeController});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  String? _lastUid;

  @override
  Widget build(BuildContext context) {
    final progress = ProgressProvider.of(context);

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return LoginScreen(
            errorMessage: snapshot.error.toString(),
            themeController: widget.themeController,
          );
        }

        final user = snapshot.data;

        if (user == null) {
          _lastUid = null;
          return LoginScreen(
            errorMessage: null,
            themeController: widget.themeController,
          );
        }

        // Attach user when UID changes so ProgressProvider has current user data.
        if (_lastUid != user.uid) {
          _lastUid = user.uid;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            progress.attachUser(user);
          });
        }

        return HomeScreen(
          themeController: widget.themeController,
        );
      },
    );
  }
}
