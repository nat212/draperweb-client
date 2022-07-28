import 'package:draperweb/src/shared/models/models.dart';
import 'package:draperweb/src/shared/providers/auth.dart';
import 'package:draperweb/src/shared/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initialiseApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initHive();
  await _initProviders();
}

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(AccountAdapter());
}

Future<void> _initProviders() async {
  await SettingsProvider.initialise();
  await AuthProvider.initialise();
}