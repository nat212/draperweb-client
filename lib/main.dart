import 'package:draperweb/src/app.dart';
import 'package:draperweb/src/init.dart';
import 'package:flutter/material.dart';

void main() async {
  await initialiseApp();

  runApp(const DraperWebApp());
}
