import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Centralized environment variables accessor.
/// All environment reads across the app should go through this class.
class Env {
  Env._();

  // Common keys (add more as needed)
  static const String _kBaseUrl = 'BASE_URL';

  /// Base URL for backend API.
  static String get baseUrl => _readString(_kBaseUrl);

  /// Generic readers
  static String _readString(String key, {String? fallback}) {
    final value = dotenv.env[key] ?? fallback;
    if (value == null || value.isEmpty) {
      throw StateError('Missing required env: $key');
    }
    return value;
  }

  static int readInt(String key, {int? fallback}) {
    final raw = dotenv.env[key];
    if (raw == null || raw.isEmpty) {
      final fb = fallback;
      if (fb == null) throw StateError('Missing required env: $key');
      return fb;
    }
    final parsed = int.tryParse(raw);
    if (parsed == null) {
      throw StateError('Env $key is not a valid int: "$raw"');
    }
    return parsed;
  }

  static bool readBool(String key, {bool? fallback}) {
    final raw = dotenv.env[key];
    if (raw == null || raw.isEmpty) {
      final fb = fallback;
      if (fb == null) throw StateError('Missing required env: $key');
      return fb;
    }
    final normalized = raw.toLowerCase().trim();
    if (normalized == 'true' || normalized == '1' || normalized == 'yes') return true;
    if (normalized == 'false' || normalized == '0' || normalized == 'no') return false;
    throw StateError('Env $key is not a valid bool: "$raw"');
  }
}


