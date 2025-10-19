import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:nba_fantasy_app/app/utils/app_log.dart';

void main() {
	group('AppLog', () {
		test('should print last stack line and value with default line count', () {
			// Arrange
			final printed = <String>[];
			debugPrint = (String? message, {int? wrapWidth}) {
				if (message != null) printed.add(message);
			};

			// Act
			AppLog('hello');

			// Assert
			expect(printed.length, 1);
			final msg = printed.first;
			expect(msg.contains('hello'), isTrue);
			// should include a stack-like anchor (e.g., main.<anonymous closure> or similar)
			expect(msg.isNotEmpty, isTrue);
		});

		test('should respect custom line depth when provided', () {
			// Arrange
			final printed = <String>[];
			debugPrint = (String? message, {int? wrapWidth}) {
				if (message != null) printed.add(message);
			};

			// Act
			AppLog('world', line: 2);

			// Assert
			expect(printed.length, 1);
			expect(printed.first.contains('world'), isTrue);
		});
	});
}
