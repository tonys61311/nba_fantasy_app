import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:nba_fantasy_app/features/login/controllers/login_controller.dart';
import 'package:nba_fantasy_app/features/login/views/login_view.dart';
import 'package:nba_fantasy_app/features/login/views/register_view.dart';

class _FakeGoogleAdapter implements GoogleSignInAdapter {
  @override
  Future<(String idToken, String accessToken)> signIn() async => ('id', 'access');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LoginView shows fields and login button', (tester) async {
    final auth = MockFirebaseAuth(signedIn: false);
    Get.testMode = true;
    Get.put<LoginController>(LoginController(auth: auth, googleAdapter: _FakeGoogleAdapter()));

    await tester.pumpWidget(const GetMaterialApp(home: LoginView()));

    expect(find.byKey(const ValueKey('emailTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('passwordTextField')), findsOneWidget);
    expect(find.byKey(const ValueKey('loginButton')), findsOneWidget);
    expect(find.textContaining("Don't have an account"), findsOneWidget);
    expect(find.byKey(const ValueKey('googleSignInButton')), findsOneWidget);
  });

  testWidgets('LoginView link navigates to RegisterView', (tester) async {
    final auth = MockFirebaseAuth(signedIn: false);
    Get.testMode = true;
    Get.put<LoginController>(LoginController(auth: auth, googleAdapter: _FakeGoogleAdapter()));

    await tester.pumpWidget(const GetMaterialApp(home: LoginView()));

    await tester.tap(find.textContaining("Don't have an account"));
    await tester.pumpAndSettle();

    // After navigation, RegisterView should be present
    expect(find.byType(RegisterView), findsOneWidget);
  });
}


