import 'package:flutter/material.dart';
import 'package:nba_fantasy_app/core/enum/bottom_nav_item.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentItem, this.onChanged});

  final BottomNavItem currentItem;
  final ValueChanged<BottomNavItem>? onChanged;

  void _handleTap(BottomNavItem item) {
    onChanged?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BottomNavigationBar(
      currentIndex: currentItem.getIndexInItems,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.unselectedWidgetColor,
      onTap: (index) => _handleTap(BottomNavItem.getItemFromIndex(index)),
      items: BottomNavItem.barItems
          .map((item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.title,
              ))
          .toList(),
    );
  }
}
