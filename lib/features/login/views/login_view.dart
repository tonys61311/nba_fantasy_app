import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'register_view.dart';
import '../../../widgets/model_tab_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  String? _idToken;
  bool _obscurePassword = true;

  LoginController get _controller => Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailLogin() async {
    await _controller.login(_emailController.text.trim(), _passwordController.text);
    if (_controller.errorMessage.value.isNotEmpty) {
      Get.snackbar('Login Failed', _controller.errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final user = _controller.currentUser;
    final token = await user?.getIdToken();
    if (!mounted) return;
    setState(() => _idToken = token);
    if (token != null) {
      Get.snackbar('Login Success', token, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _handleGoogleLogin() async {
    await _controller.signInWithGoogle();
    if (_controller.errorMessage.value.isNotEmpty) {
      Get.snackbar('Google Login Failed', _controller.errorMessage.value,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final token = await _controller.currentUser?.getIdToken();
    if (!mounted) return;
    setState(() => _idToken = token);
    if (token != null) {
      Get.snackbar('Google Login Success', token, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Obx(() {
              final isLoading = _controller.isLoading.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.sports_basketball_rounded, size: 56, color: colorScheme.primary),
                  const SizedBox(height: 12),
                  Text(
                    'NBA Fantasy App',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 24),
                  const ModelTabBar(
                    tabs: [
                      TabItem(id: 'login', name: 'Login'),
                      TabItem(id: 'register', name: 'Register'),
                    ],
                    activeId: 'login'
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    key: const ValueKey('emailTextField'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    key: const ValueKey('passwordTextField'),
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.2),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: isLoading
                          ? null
                          : () => Get.snackbar('Forgot Password', '請稍後於設定中提供重設流程', snackPosition: SnackPosition.BOTTOM),
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      key: const ValueKey('loginButton'),
                      onPressed: isLoading ? null : _handleEmailLogin,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: isLoading
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Sign In'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('or continue with', style: theme.textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withOpacity(0.7))),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      key: const ValueKey('googleSignInButton'),
                      onPressed: isLoading ? null : _handleGoogleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.surfaceContainerHighest.withOpacity(0.25),
                        foregroundColor: colorScheme.onSurface,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.g_translate),
                          SizedBox(width: 12),
                          Text('Sign in with Google'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: GestureDetector(
                      onTap: isLoading ? null : () => Get.to(() => const RegisterView()),
                      child: Text(
                        "Don't have an account? Register here.",
                        style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.primary),
                      ),
                    ),
                  ),
                  if (_idToken != null) ...[
                    const SizedBox(height: 24),
                    Text('idToken: \n$_idToken', key: const ValueKey('idTokenText')),
                  ],
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}


