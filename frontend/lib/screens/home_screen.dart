import 'package:flutter/material.dart';
import 'select_model_screen.dart';
import 'ml_basics_screen.dart';
import '../theme/theme_controller.dart';
import '../widgets/app_drawer.dart';
import 'practice_problems_screen.dart';
import '../progress/learning_progress.dart';


class HomeScreen extends StatelessWidget {
  final ThemeController themeController;

  const HomeScreen({
    super.key,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = ProgressProvider.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    const Color.fromARGB(255, 4, 18, 61),
                    const Color(0xFF1E1E1E),
                  ]
                : [
                    const Color(0xFFF5F7FF),
                    const Color(0xFFEFF2FF),
                  ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔝 Menu + Theme Toggle
                  Builder(
                    builder: (context) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white10
                                    : const Color(0xFFE6ECFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, size: 16, color: Colors.amber),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${progress.points} pts',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(
                                themeController.isDarkMode
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              onPressed: themeController.toggleTheme,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // 🧠 HERO SECTION (TEXT + IMAGE)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // LEFT: TEXT
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LABEL 2 LEARN',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Understand Machine Learning\nfrom basics to models',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Visualize • Understand • Learn\nMachine Learning Algorithms',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: isDark
                                        ? Colors.white60
                                        : Colors.black45,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 24),

                      // RIGHT: IMAGE
                      Expanded(
                        flex: 5,
                        child: Image.asset(
                          'assets/images/supervised_learning_flow.png',
                          fit: BoxFit.contain,
                          height: 320, // prevents overflow on web
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // 🔹 Learn the Basics
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark
                            ? Colors.white
                            : const Color.fromARGB(255, 4, 105, 176),
                        foregroundColor:
                            isDark ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MLBasicsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Learn the Basics',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 🔹 Explore Models
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isDark
                            ? Colors.white
                            : Colors.black,
                        side: BorderSide(
                          color: isDark
                              ? Colors.white
                              : const Color.fromARGB(255, 4, 105, 176),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const SelectModelScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Explore Models',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

SizedBox(
  width: double.infinity,
  height: 52,
  child: OutlinedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PracticeProblemsScreen(),
        ),
      );
    },
    child: const Text(
      'How do I build?',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
