import 'dart:convert';
import 'dart:typed_data';

class AppUtils {
	static Uint8List decodeDataUrl(String dataUrl) {
		if (dataUrl.isEmpty) return Uint8List(0);
		final commaIndex = dataUrl.indexOf(',');
		if (commaIndex == -1) return Uint8List(0);
		final base64Part = dataUrl.substring(commaIndex + 1);
		try {
			return base64Decode(base64Part);
		} catch (_) {
			return Uint8List(0);
		}
	}
}
