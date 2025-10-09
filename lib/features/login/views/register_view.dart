import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import 'login_view.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(key: ValueKey('emailTextField')),
            const TextField(key: ValueKey('passwordTextField'), obscureText: true),
            const TextField(key: ValueKey('confirmPasswordTextField'), obscureText: true),
            const SizedBox(height: 8),
            const ElevatedButton(key: ValueKey('registerButton'), onPressed: null, child: Text('Create Account')),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => Get.to(() => const LoginView()),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}


