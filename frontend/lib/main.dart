
// // import 'package:flutter/material.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_analytics/firebase_analytics.dart';
// // import 'package:firebase_analytics/observer.dart';
// // import 'screens/home_screen.dart';
// // import 'theme/theme_controller.dart';
// // import 'theme/app_theme.dart';
// // import 'progress/learning_progress.dart';
// // import 'firebase_options.dart';
// // import 'screens/auth_gate.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp(
// //     options: DefaultFirebaseOptions.currentPlatform,
// //   );

// //   // Enable offline persistence for Firestore when supported; some web contexts
// //   // (incognito, certain browsers, or blocked storage) throw a NativeError when
// //   // IndexedDB is unavailable. We guard this so points sync does not crash.
// //   if (!kIsWeb) {
// //     FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
// //   } else {
// //     try {
// //       FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
// //     } catch (e) {
// //       debugPrint('Firestore persistence disabled on web: $e');
// //     }
// //   }

// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   final ThemeController themeController = ThemeController();
// //   final LearningProgress progress = LearningProgress();
// //   final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

// //   MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimatedBuilder(
// //       animation: themeController,
// //       builder: (context, _) {
// //         return ProgressProvider(
// //           progress: progress,
// //           child: MaterialApp(
// //             debugShowCheckedModeBanner: false,
// //             title: 'Supervised Learning App',
// //             navigatorObservers: [
// //               FirebaseAnalyticsObserver(analytics: analytics),
// //             ],

// //             theme: AppTheme.lightTheme,
// //             darkTheme: AppTheme.darkTheme,
// //             themeMode: themeController.themeMode,

// //             home: AuthGate(
// //               themeController: themeController,
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_analytics/observer.dart';

// import 'firebase_options.dart';
// import 'screens/auth_gate.dart';
// import 'screens/home_screen.dart';
// import 'theme/theme_controller.dart';
// import 'theme/app_theme.dart';
// import 'progress/learning_progress.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   // 🔐 SIGN IN ANONYMOUSLY (CRITICAL FIX)
//   final auth = FirebaseAuth.instance;
//   if (auth.currentUser == null) {
//     await auth.signInAnonymously();
//     debugPrint('✅ Signed in anonymously: ${auth.currentUser?.uid}');
//   }

//   // Firestore offline persistence (safe for web)
//   if (!kIsWeb) {
//     FirebaseFirestore.instance.settings =
//         const Settings(persistenceEnabled: true);
//   } else {
//     try {
//       FirebaseFirestore.instance.settings =
//           const Settings(persistenceEnabled: true);
//     } catch (e) {
//       debugPrint('Firestore persistence disabled on web: $e');
//     }
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   static final ThemeController themeController = ThemeController();
//   static final LearningProgress progress = LearningProgress();
//   static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: themeController,
//       builder: (context, _) {
//         return ProgressProvider(
//           progress: progress,
//           child: MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Supervised Learning App',
//             navigatorObservers: [
//               FirebaseAnalyticsObserver(analytics: analytics),
//             ],
//             theme: AppTheme.lightTheme,
//             darkTheme: AppTheme.darkTheme,
//             themeMode: themeController.themeMode,
//             home: AuthGate(
//               themeController: themeController,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'firebase_options.dart';
import 'screens/auth_gate.dart';
import 'theme/theme_controller.dart';
import 'theme/app_theme.dart';
import 'progress/learning_progress.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Optional: ensure a user exists (e.g., anonymous) before loading UI.
  final auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    await auth.signInAnonymously();
  }

  // Firestore offline persistence (guarded on web to avoid IndexedDB errors).
  if (!kIsWeb) {
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  } else {
    try {
      FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
    } catch (e) {
      debugPrint('Firestore persistence disabled on web: $e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final ThemeController themeController = ThemeController();
  static final LearningProgress progress = LearningProgress();
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return ProgressProvider(
          progress: progress,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Supervised Learning App',
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeController.themeMode,
            home: AuthGate(
              themeController: themeController,
            ),
          ),
        );
      },
    );
  }
}
