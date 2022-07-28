import 'package:draperweb/src/shared/extensions.dart';
import 'package:draperweb/src/shared/providers/theme.dart';
import 'package:draperweb/src/shared/views/adaptive_padding.dart';
import 'package:draperweb/src/shared/views/spaced_column.dart';
import 'package:draperweb/src/shared/views/spaced_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class _Shortcut {
  final String label;
  final String icon;
  final String url;

  const _Shortcut({
    required this.label,
    required this.icon,
    required this.url,
  });
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  static const List<_Shortcut> _ecosystemShortcuts = [
    _Shortcut(
      url: 'https://box.draper.net.za/mail',
      icon: 'assets/logo/roundcube.svg',
      label: 'Draper Mail',
    ),
    _Shortcut(
      url: 'https://box.draper.net.za/cloud',
      icon: 'assets/logo/nextcloud.svg',
      label: 'Draper Cloud',
    ),
    _Shortcut(
      url: 'https://box.draper.net.za/admin',
      icon: 'assets/logo/draperweb.svg',
      label: 'Draper Admin',
    ),
  ];

  static const List<_Shortcut> _mediaShortcuts = [
    _Shortcut(
      url: 'http://192.168.0.100:8989',
      icon: 'assets/logo/sonarr.svg',
      label: 'Sonarr (Series)',
    ),
    _Shortcut(
      url: 'http://192.168.0.100:7878',
      icon: 'assets/logo/radarr.svg',
      label: 'Radarr (Movies)',
    ),
    _Shortcut(
      url: 'http://192.168.0.100:8686',
      icon: 'assets/logo/lidarr.png',
      label: 'Lidarr (Music)',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: AdaptivePadding(
            maxWidth: constraints.isDesktop ? 1200 : 600,
            child: _body(context, constraints),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, BoxConstraints constraints) {
    return !constraints.isDesktop
        ? SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Shortcuts', style: Theme.of(context).textTheme.headline5),
              Text('Draper Ecosystem',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.75))),
              SpacedRow(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final shortcut in constraints.maxWidth <= 600
                      ? _ecosystemShortcuts.getRange(0, 2)
                      : _ecosystemShortcuts)
                    _DashboardShortcut(shortcut: shortcut),
                ],
              ),
              if (constraints.maxWidth <= 600)
                _DashboardShortcut(shortcut: _ecosystemShortcuts.last),
              Text('Media System',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.75))),
              SpacedRow(
                children: [
                  for (final shortcut in constraints.maxWidth <= 600
                      ? _mediaShortcuts.getRange(0, 2)
                      : _mediaShortcuts)
                    _DashboardShortcut(shortcut: shortcut),
                ],
              ),
              if (constraints.maxWidth <= 600)
                _DashboardShortcut(shortcut: _mediaShortcuts.last),
            ],
          )
        : SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shortcuts', style: Theme.of(context).textTheme.headline5),
              SpacedRow(
                spacing: 128,
                children: [
                  SpacedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Draper Ecosystem',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.75))),
                      SpacedRow(
                        children: [
                          for (final shortcut in _ecosystemShortcuts)
                            _DashboardShortcut(shortcut: shortcut),
                        ],
                      )
                    ],
                  ),
                  SpacedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Media System',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.75))),
                      SpacedRow(
                        children: [
                          for (final shortcut in _mediaShortcuts)
                            _DashboardShortcut(shortcut: shortcut),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          );
  }
}

class _DashboardShortcut extends StatelessWidget {
  const _DashboardShortcut({Key? key, required this.shortcut})
      : super(key: key);
  final _Shortcut shortcut;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 128,
      width: 128,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: ThemeProvider.of(context).mediumBorderRadius,
        color: Theme.of(context).colorScheme.surfaceVariant,
      ),
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse(shortcut.url));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: shortcut.icon.endsWith('.svg')
                    ? SvgPicture.asset(shortcut.icon)
                    : Image.asset(shortcut.icon),
              ),
              Text(shortcut.label),
            ],
          ),
        ),
      ),
    );
  }
}
