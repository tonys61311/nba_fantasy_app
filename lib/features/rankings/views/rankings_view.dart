import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/features/rankings/controllers/rankings_controller.dart';
import 'package:nba_fantasy_app/features/rankings/models/player_ranking.dart';
import 'package:nba_fantasy_app/features/rankings/widgets/compact_ranking_item.dart';
import 'package:nba_fantasy_app/features/rankings/widgets/expanded_ranking_item.dart';
import 'package:nba_fantasy_app/core/models/league_standings_response.dart';

class RankingsView extends StatelessWidget {
  const RankingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingsController controller =
        Get.isRegistered<RankingsController>() ? Get.find<RankingsController>() : Get.put(RankingsController());
    // theme kept here previously; no need now

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.error.value.isNotEmpty) {
        return Center(child: Text('Error: ${controller.error.value}'));
      }

      final List<TeamStanding> standings = controller.standings;
      final List<PlayerRanking> items = standings
          .map((t) => PlayerRanking(
                id: t.teamId,
                teamName: t.teamName,
                teamAbbrev: t.teamAbbrev,
                position: '',
                avatarUrl: t.logoUrl,
                avatarBase64: t.logoBase64,
                fantasyPoints: t.points,
                rank: t.standing,
                firstName: t.owners.first.firstName,
                lastName: t.owners.first.lastName,
              ))
          .toList();

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (_, index) {
          final player = items[index];
          final isExpanded = index == 0;
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: isExpanded
                ? ExpandedRankingItem(player: player)
                : CompactRankingItem(player: player),
          );
        },
      );
    });
  }
}


