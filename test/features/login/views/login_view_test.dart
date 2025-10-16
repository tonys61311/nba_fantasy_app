import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:nba_fantasy_app/features/login/controllers/login_controller.dart';
import 'package:nba_fantasy_app/features/login/views/login_view.dart';
import 'package:nba_fantasy_app/features/login/views/register_view.dart';
import 'package:nba_fantasy_app/core/services/auth_service.dart';
import 'package:nba_fantasy_app/app/routes/app_router.dart';
import 'package:nba_fantasy_app/features/login/controllers/register_controller.dart';

class _FakeGoogleAdapter implements GoogleSignInAdapter {
  @override
  Future<(String idToken, String accessToken)> signIn() async => ('id', 'access');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LoginView shows fields and login button', (tester) async {
    final auth = MockFirebaseAuth(signedIn: false);
    Get.testMode = true;
    Get.put<AuthService>(AuthService(auth: auth).init(), permanent: true);
    Get.put<LoginController>(LoginController(auth: auth, googleAdapter: _FakeGoogleAdapter()));
    // 預先註冊 RegisterController 以避免首次 build 取用時未註冊
    Get.put<RegisterController>(RegisterController(auth: auth));

    await tester.pumpWidget(GetMaterialApp(getPages: AppRouter.pages, home: const LoginView()));

    expect(find.byKey(const ValueKey('emailTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('passwordTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('loginButton')), findsOneWidget);
    expect(find.textContaining("Don't have an account"), findsOneWidget);
    expect(find.byKey(const ValueKey('googleSignInButton')), findsOneWidget);
  });

  testWidgets('LoginView link navigates to RegisterView', (tester) async {
    final auth = MockFirebaseAuth(signedIn: false);
    Get.testMode = true;
    Get.put<AuthService>(AuthService(auth: auth).init(), permanent: true);
    Get.put<LoginController>(LoginController(auth: auth, googleAdapter: _FakeGoogleAdapter()));

    await tester.pumpWidget(GetMaterialApp(getPages: AppRouter.pages, home: const LoginView()));

    // 確保按鈕在螢幕內可點擊
    await tester.ensureVisible(find.text('Register here.'));
    await tester.tap(find.text('Register here.'));
    await tester.pumpAndSettle();

    // After navigation, RegisterView should be present
    expect(find.byType(RegisterView), findsOneWidget);
  });
}


