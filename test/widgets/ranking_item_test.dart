import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/app/theme/app_theme.dart';
import 'package:nba_fantasy_app/features/rankings/models/player_ranking.dart';
import 'package:nba_fantasy_app/features/rankings/widgets/ranking_item.dart';

void main() {
  Get.testMode = true;

  const sample = PlayerRanking(
    id: '1',
    teamName: 'Nikola Jokic',
    teamAbbrev: 'Denver Nuggets',
    position: 'C',
    avatarUrl: 'https://example.com/jokic.png',
    avatarBase64: '',
    fantasyPoints: 58.2,
    rank: 1,
    firstName: 'Nikola',
    lastName: 'Jokic',
  );

  group('RankingItem', () {
    testWidgets('renders expanded mode with View Profile button', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          theme: AppTheme.dark(),
          home: const Scaffold(
            body: RankingItem(
              player: sample,
              mode: RankingDisplayMode.expanded,
            ),
          ),
        ),
      );

      expect(find.text('View Profile'), findsOneWidget);
      expect(find.textContaining('Fantasy Points'), findsOneWidget);
      expect(find.text(sample.teamName), findsOneWidget);
    });

    testWidgets('renders compact mode without View Profile button and right-aligned points', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: SizedBox(
              width: 360,
              child: RankingItem(
                player: sample.copyWith(rank: 2, fantasyPoints: 55.9),
                mode: RankingDisplayMode.compact,
              ),
            ),
          ),
        ),
      );

      expect(find.text('View Profile'), findsNothing);
      expect(find.textContaining('FPTS'), findsOneWidget);
    });
  });
}


