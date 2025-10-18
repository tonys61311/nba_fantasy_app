import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nba_fantasy_app/core/api/app_api.dart';
import 'package:nba_fantasy_app/core/services/auth_service.dart';
import 'package:nba_fantasy_app/app/routes/app_router.dart';

/// Adapter interface for Google Sign-In. Implementation will be provided later.
abstract class GoogleSignInAdapter {
  Future<(String idToken, String accessToken)> signIn();
}

class LoginController extends GetxController {
  LoginController({FirebaseAuth? auth, GoogleSignInAdapter? googleAdapter})
      : _auth = auth ?? FirebaseAuth.instance,
        _googleAdapter = googleAdapter,
        _authService = Get.find<AuthService>();

  final FirebaseAuth _auth;
  final GoogleSignInAdapter? _googleAdapter;
  final AuthService _authService;
  AppApi get _api => AppApi();

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

      // 呼叫後端 API 並保存使用者資訊
      final backendUser = await _api.login();
      _authService.setBackendUser(backendUser);
      // ignore: avoid_print
      print('backend user: uid=${backendUser.uid}, email=${backendUser.email}, role=${backendUser.role}');

      // 依角色導頁（範例：只有 role = admin 或 user 才能進首頁）
      final role = backendUser.role;
      if (role == 'admin' || role == 'user') {
        await AppRouter.offAll(AppRoute.home);
      } else {
        errorMessage.value = '沒有權限（role: $role）';
      }
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

      // 與後端建立 session 並保存
      final backendUser = await _api.login();
      _authService.setBackendUser(backendUser);
      final role = backendUser.role;
      if (role == 'admin' || role == 'user') {
        await AppRouter.offAll(AppRoute.home);
      } else {
        errorMessage.value = '沒有權限（role: $role）';
      }
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? e.code;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  User? get currentUser => _authService.currentUser;
  String? get currentRole => _authService.role;
}


