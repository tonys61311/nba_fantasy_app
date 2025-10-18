import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:nba_fantasy_app/widgets/app_header.dart';

void main() {
  group('AppHeader', () {
    testWidgets('should render centered title and left/right icons with theme colors', (tester) async {
      const title = 'League Rankings';

      final theme = ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.orange,
          onSurface: Colors.black,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blueGrey),
        useMaterial3: true,
      );

      await tester.pumpWidget(
        GetMaterialApp(
          theme: theme,
          home: const Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppHeader(title: title),
            ),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
      expect(find.byIcon(Icons.sports_basketball_outlined), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    });
  });
}
