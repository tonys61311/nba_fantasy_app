import 'package:flutter/material.dart';
import 'package:nba_fantasy_app/app/utils/app_utils.dart';
import 'package:nba_fantasy_app/features/rankings/models/player_ranking.dart';

Widget _rankCrownBadge(ThemeData theme) {
  return Positioned(
    top: 14,
    left: 14,
    child: Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFFF9A825), Color(0xFFFFD54F)],
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x80F9A825), blurRadius: 10, spreadRadius: 1),
        ],
        border: Border.all(color: const Color(0xFFFFE082), width: 1.5),
      ),
      child:
          const Icon(Icons.emoji_events_rounded, color: Colors.white, size: 24),
    ),
  );
}

class ExpandedRankingItem extends StatelessWidget {
  const ExpandedRankingItem({super.key, required this.player});

  final PlayerRanking player;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFF4C542), width: 5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66F4C542),
            blurRadius: 24,
            spreadRadius: 1,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background: portrait + subtle gold glow
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.2,
                  colors: [Color(0x33FFD54F), Color(0x00000000)],
                ),
                color: Colors.black,
              ),
            ),
            // Player portrait
            AspectRatio(
              aspectRatio: 1,
              child: Image.memory(
                AppUtils.decodeDataUrl(player.avatarBase64),
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
              ),
            ),

            // Crown rank badge (#1)
            _rankCrownBadge(theme),

            // Bottom info panel
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.05),
                      Colors.black.withOpacity(0.55),
                      Colors.black.withOpacity(0.72),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${player.firstName} ${player.lastName}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${player.teamName}, ${player.position}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white.withOpacity(0.70),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'Fantasy Points',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: const Color(0xFFFFC107),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              player.fantasyPoints.toStringAsFixed(1),
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Right: CTA
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFA000), Color(0xFFFFC107)],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x66FFC107),
                              blurRadius: 14,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Text(
                          'View Profile',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


