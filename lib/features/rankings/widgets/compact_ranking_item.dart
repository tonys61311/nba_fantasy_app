import 'package:flutter/material.dart';
import 'package:nba_fantasy_app/app/utils/app_utils.dart';
import 'package:nba_fantasy_app/features/rankings/models/player_ranking.dart';

class CompactRankingItem extends StatelessWidget {
  const CompactRankingItem({super.key, required this.player});

  final PlayerRanking player;

  Widget _rankNumberBadge(int rank) {
    return Positioned(
      left: -2,
      top: -2,
      child: Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFE6E6E6),
              Color(0xFFB9B9B9),
              Color(0xFF8A8A8A),
              Color(0xFFE0E0E0),
              Color(0xFFFFFFFF),
            ],
            stops: [0.00, 0.12, 0.32, 0.58, 0.82, 1.00],
            transform: GradientRotation(-2),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 2)),
            BoxShadow(color: Color(0x33FFFFFF), blurRadius: 1.5, offset: Offset(-1, -1)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF717172), Color(0xFF585857)],
              ),
            ),
            child: Center(
              child: Text(
                '$rank',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final BorderRadius borderRadius = BorderRadius.circular(16);

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      tween: Tween(begin: 0, end: 0),
      builder: (context, _, __) {
        return GestureDetector(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.all(2),
            height: 76,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE0E0E0),
                  Color(0xFFFEF734),
                  Color(0xFFDE9500)
                ],
                stops: [0.0, 0.3, 1.0],
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(-4, -4)),
                BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 4)),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1C1C1C), Color(0xFF0E0E0E)],
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: avatar with gold ring and rank badge
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const SweepGradient(
                            colors: [
                              Color(0xFFFFF3C0),
                              Color(0xFFFFC107),
                              Color(0xFFB57E10),
                              Color(0xFFFFD54F),
                              Color(0xFFFFF3C0),
                            ],
                            stops: [0.0, 0.18, 0.42, 0.76, 1.0],
                            transform: GradientRotation(-2),
                          ),
                          border: Border.all(color: Colors.black, width: 1),
                          boxShadow: const [
                            BoxShadow(color: Color(0x66FFD54F), blurRadius: 12, offset: Offset(0, 6)),
                            BoxShadow(color: Color(0x26FFFFFF), blurRadius: 2, offset: Offset(-2, -2)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: CircleAvatar(
                              backgroundImage: MemoryImage(
                                AppUtils.decodeDataUrl(player.avatarBase64),
                              ),
                              onBackgroundImageError: (e, s) => Container(
                                color: theme.colorScheme.surfaceContainerHighest,
                              ),
                            ),
                          ),
                        ),
                      ),
                      _rankNumberBadge(player.rank),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // Right: info and score
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${player.firstName} ${player.lastName}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${player.teamAbbrev}, ${player.position}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFFB0B0B0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${player.fantasyPoints.toStringAsFixed(1)} FPTS',
                          textAlign: TextAlign.right,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


