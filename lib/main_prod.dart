import 'package:draperweb/src/app.dart';
import 'package:draperweb/src/init.dart';
import 'package:flutter/material.dart';

import 'flavors.dart';

void main() async {
  F.appFlavor = Flavor.prod;
  await initialiseApp();
  runApp(const DraperWebApp());
}
