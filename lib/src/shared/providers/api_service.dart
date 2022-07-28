
import 'package:draperweb/Constants.dart';

import 'auth.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final AuthProvider _authProvider;

  ApiService(this._authProvider);

  static String _getAuthorisationHeaderValue(String token) {
    return 'Bearer $token';
  }

  Map<String, String>? _addAuthHeaders(Map<String, String>? headers) {
    if (_authProvider.loggedIn) {
      headers ??= {};
      headers['Authorization'] = _getAuthorisationHeaderValue(_authProvider.value!);
    }
    return headers;
  }

  static Uri getApiUri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri(
      scheme: Constants.apiScheme,
      host: Constants.apiHost,
      port: Constants.apiPort,
      path: '${Constants.apiBaseUrl}/$path',
      queryParameters: queryParameters,
    );
  }

  Future<http.Response> get(String path,
      {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) {
    return http.get(getApiUri(path, queryParameters: queryParameters),
        headers: _addAuthHeaders(headers));
  }

  Future<http.Response> post(String path, Object? body,
      {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) {
    return http.post(getApiUri(path, queryParameters: queryParameters),
        body: body, headers: _addAuthHeaders(headers));
  }

  Future<http.Response> put(String path, Object? body,
      {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) {
    return http.put(getApiUri(path, queryParameters: queryParameters),
        body: body, headers: _addAuthHeaders(headers));
  }

  Future<http.Response> patch(String path, Object? body,
      {Map<String, dynamic>? queryParameters, Map<String, String>? headers}) {
    return http.patch(getApiUri(path, queryParameters: queryParameters),
        body: body, headers: _addAuthHeaders(headers));
  }
}