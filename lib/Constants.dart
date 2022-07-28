import 'package:flutter/foundation.dart';

class Constants {
  static String apiScheme = kReleaseMode ? 'https' : 'http';
  static String apiHost = kReleaseMode
      ? 'web.draper.net.za'
      : defaultTargetPlatform == TargetPlatform.android
          ? '10.0.2.2'
          : 'localhost';
  static String apiBaseUrl = '/api';
  static int? apiPort = kReleaseMode ? null : 8282;

  static String get apiUrl =>
      '$apiScheme://$apiHost${apiPort == null ? '' : ':$apiPort'}$apiBaseUrl';
}
