import 'package:nba_fantasy_app/core/api/api_base.dart';
import 'package:nba_fantasy_app/core/models/user_response.dart';

class AppApi {
  AppApi._();

  static final ApiBase _api = ApiBase();

  /// POST /auth/login
  static Future<UserResponse> login() async {
    return _api.request<UserResponse>('/auth/login');
  }

  /// POST /auth/register
  static Future<UserResponse> register() async {
    return _api.request<UserResponse>('/auth/register');
  }
}


