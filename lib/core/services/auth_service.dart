import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/core/models/user_response.dart';

/// 集中管理 Firebase User 與後端使用者（含 role），便於全域取得。
class AuthService extends GetxService {
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  final Rxn<User> _firebaseUser = Rxn<User>();
  final Rxn<UserResponse> _backendUser = Rxn<UserResponse>();

  User? get currentUser => _firebaseUser.value ?? _auth.currentUser;
  String? get idToken => null; // 只在需要時即時抓取，避免過期
  UserResponse? get backendUser => _backendUser.value;
  String? get role => _backendUser.value?.role;

  AuthService init() {
    _firebaseUser.value = _auth.currentUser;
    _auth.userChanges().listen((u) => _firebaseUser.value = u);
    return this;
  }

  Future<String?> getIdToken() async {
    final user = currentUser;
    return user?.getIdToken();
  }

  void setBackendUser(UserResponse user) {
    _backendUser.value = user;
  }

  void clearBackendUser() {
    _backendUser.value = null;
  }
}


