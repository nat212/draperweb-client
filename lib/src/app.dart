import 'package:draperweb/src/shared/providers/settings.dart';
import 'package:draperweb/src/shared/providers/theme.dart';
import 'package:draperweb/src/shared/router.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

class DraperWebApp extends StatefulWidget {
  const DraperWebApp({Key? key}) : super(key: key);

  @override
  State<DraperWebApp> createState() => _DraperWebAppState();
}

class _DraperWebAppState extends State<DraperWebApp> {
  final settings = ValueNotifier(ThemeSettings(
      sourceColor: const Color(0xFF4DB6AC),
      themeMode: SettingsProvider.themeMode));

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => ThemeProvider(
        settings: settings,
        lightDynamic: lightDynamic,
        darkDynamic: darkDynamic,
        child: NotificationListener<ThemeSettingsChange>(
          onNotification: (notification) {
            settings.value = notification.settings;
            return true;
          },
          child: ValueListenableBuilder<ThemeSettings>(
            valueListenable: settings,
            builder: (context, value, _) {
              final theme = ThemeProvider.of(context);
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'DraperWeb',
                theme: theme.light(settings.value.sourceColor),
                darkTheme: theme.dark(settings.value.sourceColor),
                themeMode: theme.themeMode(),
                routeInformationParser: appRouter.routeInformationParser,
                routerDelegate: appRouter.routerDelegate,
                routeInformationProvider: appRouter.routeInformationProvider,
              );
            },
          ),
        ),
      ),
    );
  }
}
