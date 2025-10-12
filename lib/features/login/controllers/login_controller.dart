import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nba_fantasy_app/core/api/app_api.dart';

/// Adapter interface for Google Sign-In. Implementation will be provided later.
abstract class GoogleSignInAdapter {
  Future<(String idToken, String accessToken)> signIn();
}

class LoginController extends GetxController {
  LoginController({FirebaseAuth? auth, GoogleSignInAdapter? googleAdapter})
      : _auth = auth ?? FirebaseAuth.instance,
        _googleAdapter = googleAdapter;

  final FirebaseAuth _auth;
  final GoogleSignInAdapter? _googleAdapter;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.isEmpty) {
      errorMessage.value = '請輸入 Email 與 Password';
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      final user = _auth.currentUser;
      // Log for verification in console during manual testing
      // ignore: avoid_print
      print('login success: ${user?.email}');

      // Call backend API after Firebase login
      final backendUser = await AppApi.login();
      // ignore: avoid_print
      print('backend user: uid=${backendUser.uid}, email=${backendUser.email}, role=${backendUser.role}');
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? e.code;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    final adapter = _googleAdapter;
    if (adapter == null) {
      errorMessage.value = 'Google 登入不可用';
      return;
    }
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final tokens = await adapter.signIn();
      final credential = GoogleAuthProvider.credential(
        idToken: tokens.$1,
        accessToken: tokens.$2,
      );
      await _auth.signInWithCredential(credential);
      final user = _auth.currentUser;
      // ignore: avoid_print
      print('google login success: ${user?.email}');
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


