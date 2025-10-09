import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
// ignore_for_file: unused_import
import 'package:nba_fantasy_app/features/login/controllers/register_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RegisterController', () {
    test('should create account successfully', () async {
      final auth = MockFirebaseAuth(signedIn: false);
      final controller = RegisterController(auth: auth);
      await controller.register('new@test.com', 'pw123456', 'pw123456');
      expect(controller.currentUser, isNotNull);
      expect(controller.errorMessage.value, isEmpty);
    });

    test('should show error when passwords mismatch', () async {
      final auth = MockFirebaseAuth(signedIn: false);
      final controller = RegisterController(auth: auth);
      await controller.register('a@test.com', 'a1', 'a2');
      expect(controller.errorMessage.value, isNotEmpty);
    });
  });
}


