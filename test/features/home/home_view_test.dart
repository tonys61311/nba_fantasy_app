import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/features/home/home_view.dart';
import 'package:nba_fantasy_app/features/rankings/views/rankings_view.dart';

void main() {
  group('HomeView', () {
    testWidgets('should default to Rankings tab with header and bottom nav', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeView(),
        ),
      );

      // Title reflects current tab
      expect(find.text('Rankings'), findsWidgets);
      // Body shows RankingsView via PageView
      expect(find.byType(RankingsView), findsOneWidget);
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('swipe gesture should change tab and sync header', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: HomeView(),
        ),
      );

      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Players'), findsWidgets);
    });
  });
}
