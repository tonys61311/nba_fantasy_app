import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../controllers/login_controller.dart';
import '../../../widgets/app_text_field.dart';
import '../../../widgets/app_button.dart';
import '../../../app/utils/app_notify.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  RegisterController get _controller => Get.find<RegisterController>();
  LoginController get _loginController => Get.find<LoginController>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailRegister() async {
    await _controller.register(
      _emailController.text.trim(),
      _passwordController.text,
      _confirmPasswordController.text,
    );
    if (_controller.errorMessage.value.isNotEmpty) {
      AppNotify.snackbar('Register Failed', _controller.errorMessage.value);
      return;
    }
    AppNotify.snackbar('Register Success', '帳號已建立');
  }

  Future<void> _handleGoogleContinue() async {
    await _loginController.signInWithGoogle();
    if (_loginController.errorMessage.value.isNotEmpty) {
      AppNotify.snackbar('Google Sign-In Failed', _loginController.errorMessage.value);
      return;
    }
    AppNotify.snackbar('Google Sign-In Success', '歡迎加入');
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
                  const SizedBox(height: 8),
                  Text(
                    'Create your fantasy account and join the league.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    key: const ValueKey('emailTextField'),
                    controller: _emailController,
                    label: 'Email',
                    type: AppTextFieldType.email,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    key: const ValueKey('passwordTextField'),
                    controller: _passwordController,
                    label: 'Password',
                    type: AppTextFieldType.password,
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    key: const ValueKey('confirmPasswordTextField'),
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    type: AppTextFieldType.password,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 56,
                    child: AppButton(
                      key: const ValueKey('registerButton'),
                      label: 'Create Account',
                      onPressed: isLoading ? null : _handleEmailRegister,
                      backgroundColor: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('or continue with',
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7))),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 56,
                    child: AppButton.google(
                      key: const ValueKey('googleContinueButton'),
                      label: 'Continue with Google',
                      onPressed: isLoading ? null : _handleGoogleContinue,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'By registering, you agree to our Terms & Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Already have an account?',
                          style: theme.textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: isLoading ? null : () => Get.back<void>(),
                          child: Text(
                            'Sign in here.',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}


