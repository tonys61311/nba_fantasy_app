import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:nba_fantasy_app/main.dart' as app;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Login flow', () {
    testWidgets('should login and display backend JSON', (tester) async {
      // Firebase.initializeApp() will be a no-op with firebase_auth_mocks usage

      final mockAuth = MockFirebaseAuth();

      final mockClient = MockClient((http.Request request) async {
        expect(request.url.toString(), equals('http://localhost:3000/auth/login'));
        // Ensure Authorization header present (value content not strictly asserted here)
        expect(request.headers.containsKey('Authorization'), isTrue);
        return http.Response('{"ok": true, "user": "u1"}', 200, headers: {
          'content-type': 'application/json',
        });
      });

      await tester.pumpWidget(
        MaterialApp(
          home: app.MyHomePage(
            auth: mockAuth,
            httpClient: mockClient,
            title: 't',
          ),
        ),
      );

      // Enter email and password
      await tester.enterText(find.byKey(const ValueKey('emailField')), 'test@example.com');
      await tester.enterText(find.byKey(const ValueKey('passwordField')), 'password123');

      // Tap login
      await tester.tap(find.byKey(const ValueKey('loginButton')));
      await tester.pumpAndSettle();

      // Expect JSON result rendered
      expect(find.byKey(const ValueKey('resultText')), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) => w is Text && w.data != null && w.data!.contains('"ok": true'),
        ),
        findsOneWidget,
      );
    });
  });
}


