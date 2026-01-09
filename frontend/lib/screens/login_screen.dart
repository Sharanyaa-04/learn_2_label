import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../progress/learning_progress.dart';
import '../theme/theme_controller.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final String? errorMessage;
  final ThemeController themeController;
  const LoginScreen({super.key, this.errorMessage, required this.themeController});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Sign-in failed');
    } catch (_) {
      _showError('Sign-in failed');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  void _continueAsGuest() {
    final progress = ProgressProvider.of(context);
    progress.attachUser(null);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(themeController: widget.themeController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1A237E),
                    const Color(0xFF0D47A1),
                    const Color(0xFF01579B),
                  ]
                : [
                    const Color(0xFF5E35B1),
                    const Color(0xFF3949AB),
                    const Color(0xFF1E88E5),
                  ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Logo/Icon
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.school_rounded,
                                size: 64,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 24),
                            
                            // Title
                            const Text(
                              'Welcome Back!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sign in to continue your learning journey',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            
                            // Error message
                            if (widget.errorMessage != null) ...[
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.red.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.red.shade800, size: 20),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        widget.errorMessage!,
                                        style: TextStyle(color: Colors.red.shade800),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            
                            const SizedBox(height: 28),
                            
                            // Email field
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) =>
                                  v != null && v.contains('@') ? null : 'Enter a valid email',
                            ),
                            const SizedBox(height: 16),
                            
                            // Password field
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                              ),
                              obscureText: true,
                              validator: (v) =>
                                  v != null && v.length >= 6 ? null : 'At least 6 characters',
                            ),
                            const SizedBox(height: 28),
                            
                            // Sign in button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _loading ? null : _login,
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                ),
                                child: _loading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Divider
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.grey[300])),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.grey[300])),
                              ],
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Create account button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton.icon(
                                onPressed: _loading
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => const RegisterScreen(),
                                          ),
                                        );
                                      },
                                icon: const Icon(Icons.person_add_outlined),
                                label: const Text(
                                  'Create an Account',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Guest button
                            TextButton.icon(
                              onPressed: _loading ? null : _continueAsGuest,
                              icon: const Icon(Icons.explore_outlined, size: 20),
                              label: const Text(
                                'Continue as Guest',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
