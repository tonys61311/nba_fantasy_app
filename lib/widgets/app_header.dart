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
      title: Text(title),
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
      backgroundColor: theme.appBarTheme.backgroundColor,
      foregroundColor: foreground,
    );
  }
}
