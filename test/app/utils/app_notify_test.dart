import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:nba_fantasy_app/app/utils/app_notify.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppNotify.snackbar', () {
    testWidgets('should drop new snackbar when one is showing', (tester) async {
      Get.testMode = true;

      await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => AppNotify.snackbar('A', 'first', duration: const Duration(milliseconds: 100)),
                  child: const Text('A'),
                ),
                ElevatedButton(
                  onPressed: () => AppNotify.snackbar('B', 'second', duration: const Duration(milliseconds: 100)),
                  child: const Text('B'),
                ),
              ],
            ),
          ),
        ),
      ));

      // show first
      await tester.tap(find.text('A'));
      await tester.pump();
      expect(find.text('first'), findsOneWidget);

      // attempt to show second while first is open -> dropped
      await tester.tap(find.text('B'));
      await tester.pump();
      expect(find.text('second'), findsNothing);

      // close current then show second
      AppNotify.close();
      await tester.pumpAndSettle();
      await tester.tap(find.text('B'));
      await tester.pump();
      expect(find.text('second'), findsOneWidget);

      // wait for auto dismiss to avoid pending timers
      await tester.pump(const Duration(milliseconds: 150));
      AppNotify.close();
      await tester.pumpAndSettle();
    });
  });
}


