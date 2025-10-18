import 'package:nba_fantasy_app/core/api/api_base.dart';
import 'package:nba_fantasy_app/core/models/user_response.dart';
import 'package:nba_fantasy_app/core/models/league_standings_response.dart';

abstract class IAppApi {
  Future<LeagueStandingsResponse> fetchLeagueStandings();
}

class AppApi extends ApiBase implements IAppApi {
  AppApi._internal({super.dio, super.auth, super.baseUrl});
  AppApi.testable({super.dio, super.auth, super.baseUrl});

  static AppApi? _instance;
  factory AppApi({dio, auth, baseUrl}) {
    return _instance ??= AppApi._internal(dio: dio, auth: auth, baseUrl: baseUrl);
  }

  static void resetForTest() {
    _instance = null;
  }

  static void setInstanceForTest(AppApi instance) {
    _instance = instance;
  }

  /// Convenience static wrappers (use the singleton under the hood)
  Future<UserResponse> login() async {
    return request<UserResponse>('/auth/login');
  }

  Future<UserResponse> register() async {
    return request<UserResponse>('/auth/register');
  }

  Future<LeagueStandingsResponse> getLeagueStandings() async {
    return request<LeagueStandingsResponse>('/league/standings', method: 'GET');
  }

  @override
  Future<LeagueStandingsResponse> fetchLeagueStandings() async {
    return request<LeagueStandingsResponse>('/league/standings', method: 'GET');
  }
}


