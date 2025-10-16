import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:nba_fantasy_app/widgets/app_error_dialog.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppErrorDialog', () {
    testWidgets('should show via static show(message) and close on confirm', (tester) async {
      Get.testMode = true;

      await tester.pumpWidget(GetMaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                onPressed: () => AppErrorDialog.show(context, message: 'Oops'),
                child: const Text('Trigger'),
              ),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Trigger'));
      await tester.pumpAndSettle();

      expect(find.text('錯誤'), findsOneWidget);
      expect(find.text('Oops'), findsOneWidget);

      await tester.tap(find.text('確定'));
      await tester.pumpAndSettle();

      expect(find.text('錯誤'), findsNothing);
    });

    testWidgets('should show when RxString has value and clear on confirm', (tester) async {
      Get.testMode = true;
      final RxString error = ''.obs;

      await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              AppErrorDialogLauncher(error: error),
              Center(
                child: ElevatedButton(
                  onPressed: () => error.value = 'Bad things happened',
                  child: const Text('SetError'),
                ),
              ),
            ],
          ),
        ),
      ));

      await tester.tap(find.text('SetError'));
      await tester.pumpAndSettle();

      expect(find.text('錯誤'), findsOneWidget);
      expect(find.text('Bad things happened'), findsOneWidget);

      await tester.tap(find.text('確定'));
      await tester.pumpAndSettle();

      expect(find.text('錯誤'), findsNothing);
      expect(error.value, equals(''));
    });
  });
}


