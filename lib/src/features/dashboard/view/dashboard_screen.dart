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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: AdaptivePadding(
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Shortcuts', style: Theme.of(context).textTheme.headline5),
        Text('Draper Ecosystem',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.75))),
        const SpacedRow(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _DashboardShortcut(
                shortcut: _Shortcut(
              url: 'https://box.draper.net.za/mail',
              icon: 'assets/logo/roundcube.svg',
              label: 'Draper Mail',
            )),
            _DashboardShortcut(
                shortcut: _Shortcut(
              url: 'https://box.draper.net.za/cloud',
              icon: 'assets/logo/nextcloud.svg',
              label: 'Draper Cloud',
            )),
          ],
        ),
        const _DashboardShortcut(
          shortcut: _Shortcut(
            url: 'https://box.draper.net.za/admin',
            icon: 'assets/logo/draperweb.svg',
            label: 'Draper Admin',
          ),
        ),
        Text('Media System',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.75))),
        const SpacedRow(
          children: [
            _DashboardShortcut(
              shortcut: _Shortcut(
                url: 'http://192.168.0.100:8989',
                icon: 'assets/logo/sonarr.svg',
                label: 'Sonarr (Series)',
              ),
            ),
            _DashboardShortcut(
              shortcut: _Shortcut(
                url: 'http://192.168.0.100:7878',
                icon: 'assets/logo/radarr.svg',
                label: 'Radarr (Movies)',
              ),
            ),
          ],
        ),
        const _DashboardShortcut(
          shortcut: _Shortcut(
            url: 'http://192.168.0.100:8686',
            icon: 'assets/logo/lidarr.png',
            label: 'Lidarr (Music)',
          ),
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
      padding: const EdgeInsets.all(16),
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
    );
  }
}
