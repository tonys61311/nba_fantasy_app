import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/app/routes/app_router.dart';
import 'package:nba_fantasy_app/widgets/bottom_nav_bar.dart';
import 'package:nba_fantasy_app/core/enum/bottom_nav_item.dart';

void main() {
  group('BottomNavBar', () {
    testWidgets('should render three enum-based items', (tester) async {
      final controller = PageController(initialPage: BottomNavItem.rankings.getIndexInItems);
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNavBar(
              currentItem: BottomNavItem.rankings,
              pageController: controller,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.article_outlined), findsOneWidget);
      expect(find.byIcon(Icons.bar_chart_rounded), findsOneWidget);
      expect(find.byIcon(Icons.people_alt_outlined), findsOneWidget);
    });

    testWidgets('should call onChanged with tapped BottomNavItem', (tester) async {
      BottomNavItem? tapped;
      final controller = PageController(initialPage: BottomNavItem.news.getIndexInItems);
      await tester.pumpWidget(
        GetMaterialApp(
          getPages: AppRouter.pages,
          home: Scaffold(
            bottomNavigationBar: BottomNavBar(
              currentItem: BottomNavItem.news,
              onChanged: (item) => tapped = item,
              pageController: controller,
            ),
            body: const SizedBox.shrink(),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.bar_chart_rounded));
      await tester.pumpAndSettle();

      expect(tapped, BottomNavItem.rankings);
    });
  });
}
