import 'package:flutter/material.dart';
import 'package:nba_fantasy_app/widgets/app_scaffold.dart';
import 'package:nba_fantasy_app/core/enum/bottom_nav_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(initialItem: BottomNavItem.rankings);
  }
}
