import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/ml_basics_screen.dart';
import '../screens/select_model_screen.dart';
import '../screens/faq_screen.dart';
import '../screens/chatbot_screen.dart';
import '../screens/practice_problems_screen.dart';
import '../screens/contributors_screen.dart';
import '../progress/learning_progress.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final progress = ProgressProvider.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // 🔹 Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5B7CFA), Color(0xFF7F9CF5)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Supervised Learning',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user?.email ?? 'Guest',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${progress.points} pts',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          // 📚 Learning Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'LEARNING',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Learn the Basics'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MLBasicsScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Explore Models'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SelectModelScreen()),
              );
            },
          ),

          const Divider(),

          // 🤖 Support Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'SUPPORT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: const Text('AI Tutor'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatbotScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('FAQs'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FAQScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('How do I build?'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PracticeProblemsScreen(),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Contributors'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContributorsScreen()),
              );
            },
          ),

          const Divider(),
          if (user != null)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign out'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) Navigator.pop(context);
              },
            ),

        ],
      ),
    );
  }
}
