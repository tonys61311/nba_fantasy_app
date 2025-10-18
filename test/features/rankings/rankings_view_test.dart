import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot;
import 'package:nba_fantasy_app/app/theme/app_theme.dart';
import 'package:nba_fantasy_app/features/rankings/views/rankings_view.dart';
import 'package:nba_fantasy_app/features/rankings/controllers/rankings_controller.dart';
import 'package:nba_fantasy_app/core/api/app_api.dart';
import 'package:nba_fantasy_app/core/models/league_standings_response.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'dart:async';

void main() {
  Get.testMode = true;

  setUp(() async {
    dot.dotenv.testLoad(fileInput: '''
BASE_URL=http://localhost:3000
''');
    AppApi.resetForTest();
    // 設定單例為假 API，控制器將直接使用 AppApi() 取得此單例
    AppApi.setInstanceForTest(_FakeAppApi());
  });

  group('RankingsView', () {
    testWidgets('should show loading indicator initially', (tester) async {
      Get.put<RankingsController>(RankingsController());

      await tester.pumpWidget(
        GetMaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(body: RankingsView()),
        ),
      );

      // 初始會觸發 controller.onInit -> fetchStandings -> isLoading=true
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

class _FakeAppApi extends AppApi {
  _FakeAppApi() : super.testable(auth: MockFirebaseAuth(signedIn: false), baseUrl: 'http://localhost');

  @override
  Future<LeagueStandingsResponse> fetchLeagueStandings() async {
    // Keep loading by never completing; no timers involved to avoid pending timers failure
    return Completer<LeagueStandingsResponse>().future;
  }
}

