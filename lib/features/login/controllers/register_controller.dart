import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterController extends GetxController {
  RegisterController({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> register(String email, String password, String confirmPassword) async {
    if (email.trim().isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      errorMessage.value = '請填寫所有欄位';
      return;
    }
    if (password != confirmPassword) {
      errorMessage.value = '兩次密碼不一致';
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = _auth.currentUser;
      // ignore: avoid_print
      print('register success: ${user?.email}');
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? e.code;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  User? get currentUser => _auth.currentUser;
}


