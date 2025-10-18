import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key, required this.title});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color foreground = theme.appBarTheme.foregroundColor ?? theme.colorScheme.onSurface;
    return AppBar(
      centerTitle: true,
      title: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          final fade = FadeTransition(opacity: animation, child: child);
          final slide = SlideTransition(
            position: animation.drive(
              Tween<Offset>(begin: const Offset(0.0, 0.15), end: Offset.zero).chain(
                CurveTween(curve: Curves.easeOutCubic),
              ),
            ),
            child: fade,
          );
          return slide;
        },
        child: Text(
          title,
          key: ValueKey<String>(title),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.sports_basketball_outlined),
        onPressed: () {},
        color: foreground,
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {},
          color: foreground,
        ),
      ],
      // Slightly darker header background from the theme palette
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      foregroundColor: foreground,
    );
  }
}
