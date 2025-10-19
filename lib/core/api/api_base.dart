import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nba_fantasy_app/app/utils/app_log.dart';
import 'package:nba_fantasy_app/core/env/env.dart';
import 'package:nba_fantasy_app/core/models/user_response.dart';
import 'package:nba_fantasy_app/core/models/league_standings_response.dart';

/// A thin API client that attaches Firebase ID token automatically and
/// decodes JSON payloads into typed models via a centralized registry.
class ApiBase {
  ApiBase({
    Dio? dio,
    FirebaseAuth? auth,
    String? baseUrl,
  })  : _dio = dio ?? Dio(BaseOptions(baseUrl: baseUrl ?? _defaultBaseUrl)),
        _auth = auth ?? FirebaseAuth.instance;

  static final String _defaultBaseUrl = Env.baseUrl;

  final Dio _dio;
  final FirebaseAuth _auth;
  // Note: previously supported external factories; centralized registry is used now.

  Future<T> request<T>(
    String path, {
    String method = 'POST',
    Object? data,
    Map<String, dynamic>? query,
  }) async {
    final response = await _request(
      method: method.toUpperCase(),
      path: path,
      data: data,
      queryParameters: query,
    );
    return _decode<T>(response.data);
  }

  Future<Response<dynamic>> _request({
    required String method,
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final idToken = await _auth.currentUser?.getIdToken();
    final headers = <String, dynamic>{
      'Content-Type': 'application/json',
      if (idToken != null) 'Authorization': 'Bearer $idToken',
    };

    final Response<dynamic> response = await _dio.request<dynamic>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: method, headers: headers),
    );
    if (kDebugMode) {
      AppLog('[API $method] $path -> ${response.statusCode}\n${response.data}');
    }
    return response;
  }

  T _decode<T>(dynamic data) {
    final dynamic jsonMap = data is String ? json.decode(data) : data;
    if (jsonMap is Map<String, dynamic>) {
      return _fromJson<T>(jsonMap);
    }
    // ignore: avoid_throw_in_catch_block
    throw StateError('Unexpected response type: ${data.runtimeType}');
  }

  // Central registry. You can extend this with new models.
  static T _fromJson<T>(Map<String, dynamic> json) {
    if (T == UserResponse) return UserResponse.fromJson(json) as T;
    // League standings decoding
    if (T == LeagueStandingsResponse) return LeagueStandingsResponse.fromJson(json) as T;

    throw StateError('No decoder registered for type $T');
  }

  static String _prettifyJson(dynamic data) {
    final dynamic jsonMap = data is String ? json.decode(data) : data;
    return const JsonEncoder.withIndent('  ').convert(jsonMap);
  }
}


