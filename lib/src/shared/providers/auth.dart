import 'dart:convert';

import 'package:draperweb/Constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ValueNotifier<String?> {
  static const _boxName = 'auth';
  static const _tokenKey = 'token';

  static late final AuthProvider _instance;

  final Box _authBox;

  AuthProvider._internal(this._authBox, super.value);

  factory AuthProvider() {
    return _instance;
  }

  static Future<void> initialise() async {
    final box = await Hive.openBox(_boxName);
    final String? token = box.get(_tokenKey);
    _instance = AuthProvider._internal(box, token);
  }

  static AuthProvider get instance => _instance;

  bool get loggedIn => value != null;



  void _saveToken(String token) {
    _authBox.put(_tokenKey, token);
  }

  void _clearToken() {
    _authBox.delete(_tokenKey);
  }

  Future<void> logout() async {
    // TODO: Invalidate token
    _clearToken();
  }

  Future<void> exchangeToken({required String code}) async {
    Uri uri = Uri(
      scheme: Constants.apiScheme,
      host: Constants.apiHost,
      port: Constants.apiPort,
      path: '${Constants.apiBaseUrl}/login/social/jwt-pair/',
    );
    final response = await http.post(uri, body: {
      'provider': 'nextcloud',
      'code': code,
    });
    if (response.statusCode ~/ 200 < 100) {
      final body = jsonDecode(response.body);
      final token = body['token'];
      if (token != null) {
        _saveToken(token);
        value = token;
      }
    }
  }
}
