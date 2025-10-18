import 'package:flutter/material.dart';
import 'package:nba_fantasy_app/features/news/news_view.dart';
import 'package:nba_fantasy_app/features/players/players_view.dart';
import 'package:nba_fantasy_app/features/rankings/rankings_view.dart';

enum BottomNavItem {
  news,
  rankings,
  players;

  static List<BottomNavItem> get barItems => [news, rankings, players];

  static BottomNavItem getItemFromIndex(int index) => barItems[index];

  static List<Widget> get views => barItems.map((item) => item.view).toList();

  String get title {
    switch (this) {
      case BottomNavItem.news:
        return 'News';
      case BottomNavItem.rankings:
        return 'Rankings';
      case BottomNavItem.players:
        return 'Players';
    }
  }

  IconData get icon {
    switch (this) {
      case BottomNavItem.news:
        return Icons.article_outlined;
      case BottomNavItem.rankings:
        return Icons.bar_chart_rounded;
      case BottomNavItem.players:
        return Icons.people_alt_outlined;
    }
  }

  // return 對應的 view 
  Widget get view {
    switch (this) {
      case BottomNavItem.news:
        return const NewsView();
      case BottomNavItem.rankings:
        return const RankingsView();
      case BottomNavItem.players:
        return const PlayersView();
    }
  }

  int get getIndexInItems => barItems.indexOf(this);
}
