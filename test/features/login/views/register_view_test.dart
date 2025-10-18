import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot;
import 'package:nba_fantasy_app/features/login/controllers/register_controller.dart';
import 'package:nba_fantasy_app/features/login/views/register_view.dart';
import 'package:nba_fantasy_app/features/login/views/login_view.dart';
import 'package:nba_fantasy_app/core/services/auth_service.dart';
import 'package:nba_fantasy_app/app/routes/app_router.dart';
import 'package:nba_fantasy_app/features/login/controllers/login_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    dot.dotenv.testLoad(fileInput: '''
BASE_URL=http://localhost:3000
TEST_EMAIL=user@test.com
TEST_PASSWORD=pass1234
''');
  });

  testWidgets('RegisterView shows fields and register button', (tester) async {
    final auth = MockFirebaseAuth(signedIn: false);
    Get.testMode = true;
    Get.put<AuthService>(AuthService(auth: auth).init(), permanent: true);
    Get.put<RegisterController>(RegisterController(auth: auth));
    // 預先註冊 LoginController 以支援返回導頁
    Get.put<LoginController>(LoginController(auth: auth));

    await tester.pumpWidget(GetMaterialApp(getPages: AppRouter.pages, home: const RegisterView()));

    expect(find.byKey(const ValueKey('emailTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('passwordTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('confirmPasswordTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('registerButton')), findsOneWidget);
    expect(find.textContaining('Already have an account?'), findsOneWidget);
  });

  testWidgets('RegisterView back link navigates to LoginView', (tester) async {
    final auth = MockFirebaseAuth(signedIn: false);
    Get.testMode = true;
    Get.put<AuthService>(AuthService(auth: auth).init(), permanent: true);
    Get.put<LoginController>(LoginController(auth: auth));
    Get.put<RegisterController>(RegisterController(auth: auth));

    await tester.pumpWidget(GetMaterialApp(getPages: AppRouter.pages, home: const LoginView()));

    // 從登入頁導到註冊頁
    await tester.ensureVisible(find.text('Register here.'));
    await tester.tap(find.text('Register here.'));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterView), findsOneWidget);

    // 再從註冊頁返回登入頁
    await tester.ensureVisible(find.text('Sign in here.'));
    await tester.tap(find.text('Sign in here.'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginView), findsOneWidget);
  });
}


