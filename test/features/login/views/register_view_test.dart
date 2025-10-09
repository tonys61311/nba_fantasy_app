import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:nba_fantasy_app/features/login/controllers/register_controller.dart';
import 'package:nba_fantasy_app/features/login/views/register_view.dart';
import 'package:nba_fantasy_app/features/login/views/login_view.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('RegisterView shows fields and register button', (tester) async {
    final auth = MockFirebaseAuth(signedIn: false);
    Get.testMode = true;
    Get.put<RegisterController>(RegisterController(auth: auth));

    await tester.pumpWidget(const GetMaterialApp(home: RegisterView()));

    expect(find.byKey(const ValueKey('emailTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('passwordTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('confirmPasswordTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('registerButton')), findsOneWidget);
    expect(find.textContaining('Already have an account?'), findsOneWidget);
  });

  testWidgets('RegisterView back link navigates to LoginView', (tester) async {
    final auth = MockFirebaseAuth(signedIn: false);
    Get.testMode = true;
    Get.put<RegisterController>(RegisterController(auth: auth));

    await tester.pumpWidget(const GetMaterialApp(home: RegisterView()));

    await tester.tap(find.textContaining('Already have an account?'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginView), findsOneWidget);
  });
}


