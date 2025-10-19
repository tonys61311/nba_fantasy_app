import 'package:flutter/foundation.dart';

class AppLog {
	factory AppLog(Object value, {int line = 4}) => _getInstance(value, line);

	static AppLog? _instance;

	AppLog._();

	static AppLog _getInstance(Object value, int line) {
		_instance ??= AppLog._();
		_instance!._print(value, line);
		return _instance!;
	}

	void _print(Object value, int line) {
		final depth = line <= 0 ? 1 : line;
		Iterable<String> lines = StackTrace.current.toString().trimRight().split('\n');
		lines = lines.take(depth);
		final last = lines.isNotEmpty ? lines.last : '';
		final logLine = last.replaceAll('#${depth - 1}', '').trim();
		debugPrint('$logLine$value');
	}
}
