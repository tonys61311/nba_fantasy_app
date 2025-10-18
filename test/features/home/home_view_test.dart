import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/features/home/home_view.dart';
import 'package:nba_fantasy_app/features/rankings/views/rankings_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot;
import 'package:nba_fantasy_app/features/rankings/controllers/rankings_controller.dart';
import 'package:nba_fantasy_app/core/api/app_api.dart';
import 'package:nba_fantasy_app/core/models/league_standings_response.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {
  setUp(() async {
    dot.dotenv.testLoad(fileInput: '''
BASE_URL=http://localhost:3000
''');
    AppApi.resetForTest();
    AppApi.setInstanceForTest(_FakeAppApi());
    if (!Get.isRegistered<RankingsController>()) {
      Get.put<RankingsController>(RankingsController());
    }
  });
  group('HomeView', () {
    testWidgets('should default to Rankings tab with header and bottom nav', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeView(),
        ),
      );

      // Title reflects current tab
      expect(find.text('Rankings'), findsWidgets);
      // Body shows RankingsView via PageView
      expect(find.byType(RankingsView), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('swipe gesture should change tab and sync header', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeView(),
        ),
      );

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Players'), findsWidgets);
    });
  });
}

class _FakeAppApi extends AppApi {
  _FakeAppApi() : super.testable(auth: MockFirebaseAuth(signedIn: false), baseUrl: 'http://localhost');

  @override
  Future<LeagueStandingsResponse> fetchLeagueStandings() async {
    return const LeagueStandingsResponse(status: 'ok', seasonId: 2025, standings: []);
  }
}
