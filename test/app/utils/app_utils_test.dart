import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:nba_fantasy_app/app/utils/app_utils.dart';

void main() {
	group('AppUtils.decodeDataUrl', () {
			test('should decode valid data URL to bytes', () {
				const text = 'hello';
				final b64 = base64Encode(utf8.encode(text));
				final dataUrl = 'data:text/plain;base64,$b64';
				final bytes = AppUtils.decodeDataUrl(dataUrl);
				expect(utf8.decode(bytes), equals(text));
			});

		test('should return empty bytes when no comma found', () {
			final bytes = AppUtils.decodeDataUrl('data:image/png;base64');
			expect(bytes, equals(Uint8List(0)));
		});

		test('should return empty bytes for empty string', () {
			final bytes = AppUtils.decodeDataUrl('');
			expect(bytes, equals(Uint8List(0)));
		});

		test('should return empty bytes when base64 invalid', () {
			final bytes = AppUtils.decodeDataUrl('data:text/plain;base64,@@@');
			expect(bytes, equals(Uint8List(0)));
		});
	});
}
