import 'package:flutter/material.dart';

class RankingsView extends StatelessWidget {
  const RankingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surface,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.bar_chart_rounded, size: 72, color: theme.colorScheme.primary),
          const SizedBox(height: 12),
          Text('Rankings', style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onSurface)),
          const SizedBox(height: 8),
          Text('Swipe to explore other tabs', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7))),
        ],
      ),
    );
  }
}


