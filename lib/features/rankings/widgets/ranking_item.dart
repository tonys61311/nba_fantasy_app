import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:nba_fantasy_app/features/rankings/models/player_ranking.dart';

enum RankingDisplayMode { expanded, compact }

class RankingItem extends StatelessWidget {
  const RankingItem({super.key, required this.player, required this.mode});

  final PlayerRanking player;
  final RankingDisplayMode mode;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (mode) {
      case RankingDisplayMode.expanded:
        return _ExpandedRanking(player: player, theme: theme);
      case RankingDisplayMode.compact:
        return _CompactRanking(player: player, theme: theme);
    }
  }
}

class _ExpandedRanking extends StatelessWidget {
  const _ExpandedRanking({required this.player, required this.theme});

  final PlayerRanking player;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        clipBehavior: Clip.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large portrait
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: AspectRatio(
                  aspectRatio: 16 / 11,
                  child: Image.memory(
                    _decodeDataUrl(player.avatarBase64),
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                        color: theme.colorScheme.surfaceContainerHighest),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(player.teamName,
                      style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 8),
                  Text('${player.firstName} ${player.lastName}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.8))),
                  const SizedBox(height: 20),
                  Text('Fantasy Points',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 6),
                  Text(player.fantasyPoints.toStringAsFixed(1),
                      style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface)),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('View Profile'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactRanking extends StatelessWidget {
  const _CompactRanking({required this.player, required this.theme});

  final PlayerRanking player;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text('${player.rank}',
              style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.8))),
          const SizedBox(width: 12),
          ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Image.memory(
                _decodeDataUrl(player.avatarBase64),
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  width: 48,
                  height: 48,
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
              )),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(player.teamName,
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface)),
                const SizedBox(height: 4),
                Text('${player.firstName} ${player.lastName}',
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8))),
              ],
            ),
          ),
          Text('${player.fantasyPoints.toStringAsFixed(1)} FPTS',
              style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface)),
        ],
      ),
    );
  }
}

// Decode data URL like 'data:image/png;base64,....' into raw bytes
Uint8List _decodeDataUrl(String dataUrl) {
  final commaIndex = dataUrl.indexOf(',');
  if (commaIndex == -1) return Uint8List(0);
  final base64Part = dataUrl.substring(commaIndex + 1);
  return base64Decode(base64Part);
}
