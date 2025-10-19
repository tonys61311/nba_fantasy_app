import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/app/theme/app_theme.dart';
import 'package:nba_fantasy_app/features/rankings/models/player_ranking.dart';
import 'package:nba_fantasy_app/features/rankings/widgets/compact_ranking_item.dart';
import 'package:nba_fantasy_app/features/rankings/widgets/expanded_ranking_item.dart';

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

  group('RankingItems', () {
    testWidgets('renders expanded item with View Profile button', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ExpandedRankingItem(player: sample),
          ),
        ),
      );

      expect(find.text('View Profile'), findsOneWidget);
      expect(find.textContaining('Fantasy Points'), findsOneWidget);
      expect(find.text(sample.teamName), findsOneWidget);
    });

    testWidgets('renders compact item without View Profile button and right-aligned points', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: SizedBox(
              width: 360,
              child: CompactRankingItem(
                player: sample.copyWith(rank: 2, fantasyPoints: 55.9),
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


