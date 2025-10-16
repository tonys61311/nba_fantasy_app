import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// ignore_for_file: unused_import
import 'package:nba_fantasy_app/features/login/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/core/services/auth_service.dart';

// The controller will be implemented in lib/features/login/controllers/login_controller.dart
// ignore: avoid_classes_with_only_static_members
class _Tokens {
  static const String idToken = 'fake-id-token';
  static const String accessToken = 'fake-access-token';
}

class _MockGoogleAdapter extends Mock implements GoogleSignInAdapter {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LoginController', () {
    test('should login with email & password successfully', () async {
      // Arrange
      final auth = MockFirebaseAuth(signedIn: false);
      Get.testMode = true;
      Get.put<AuthService>(AuthService(auth: auth).init(), permanent: true);
      await auth.createUserWithEmailAndPassword(
        email: 'user@test.com',
        password: 'pw123456',
      );
      await auth.signOut();
      final controller = LoginController(auth: auth, googleAdapter: _MockGoogleAdapter());

      // Act
      await controller.login('user@test.com', 'pw123456');

      // Assert
      expect(controller.isLoading.value, isFalse);
      expect(controller.currentUser, isNotNull);
    });

    test('should set validation error when email/password empty', () async {
      final auth = MockFirebaseAuth(signedIn: false);
      Get.testMode = true;
      Get.put<AuthService>(AuthService(auth: auth).init(), permanent: true);
      final controller = LoginController(auth: auth, googleAdapter: _MockGoogleAdapter());
      await controller.login('', '');
      expect(controller.errorMessage.value, isNotEmpty);
      expect(controller.isLoading.value, isFalse);
    });

    test('should sign in with Google and succeed', () async {
      final auth = MockFirebaseAuth(signedIn: false);
      Get.testMode = true;
      Get.put<AuthService>(AuthService(auth: auth).init(), permanent: true);
      final adapter = _MockGoogleAdapter();
      when(() => adapter.signIn())
          .thenAnswer((_) async => (_Tokens.idToken, _Tokens.accessToken));
      final controller = LoginController(auth: auth, googleAdapter: adapter);

      await controller.signInWithGoogle();

      expect(controller.currentUser, isNotNull);
      expect(controller.isLoading.value, isFalse);
    });
  });
}


