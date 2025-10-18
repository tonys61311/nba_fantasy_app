import 'package:flutter/material.dart';
import 'package:nba_fantasy_app/widgets/app_header.dart';
import 'package:nba_fantasy_app/widgets/bottom_nav_bar.dart';
import 'package:nba_fantasy_app/core/enum/bottom_nav_item.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.initialItem});

  final BottomNavItem initialItem;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late final PageController _pageController;
  late BottomNavItem _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.initialItem;
    _pageController = PageController(initialPage: _currentItem.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentItem = BottomNavItem.getItemFromIndex(index);
    });
  }

  void _onNavChanged(BottomNavItem item) {
    _pageController.animateToPage(
      item.getIndexInItems,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: _currentItem.title),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: BottomNavItem.views,
      ),
      bottomNavigationBar: BottomNavBar(
        currentItem: _currentItem,
        onChanged: _onNavChanged,
      ),
    );
  }
}
