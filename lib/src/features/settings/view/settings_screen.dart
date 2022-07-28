import 'package:draperweb/src/features/settings/view/view.dart';
import 'package:draperweb/src/shared/providers/settings.dart';
import 'package:draperweb/src/shared/providers/theme.dart';
import 'package:draperweb/src/shared/views/adaptive_padding.dart';
import 'package:draperweb/src/shared/views/spaced_column.dart';
import 'package:draperweb/src/shared/views/spaced_row.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: AdaptivePadding(
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildThemeModeToggle(),
            const SizedBox(height: 16),
            _buildThemeToggle(),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return SpacedColumn(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: const Text('Theme'),
          ),
      SpacedRow(
        children: [
          ThemePreview(
            colorScheme: Theme.of(context).colorScheme,
            title: 'Dynamic',
          ),
          ThemePreview(
              colorScheme: ThemeProvider.colorScheme(
                  Brightness.dark, const Color(0xFF006877)),
              title: 'Blue'),
        ],
      ),
    ]);
  }

  Widget _buildThemeModeToggle() {
    return DropdownButtonFormField<ThemeMode>(
        decoration: const InputDecoration(
          labelText: 'Theme Mode',
        ),
        value: SettingsProvider.themeMode,
        items: const [
          DropdownMenuItem(value: ThemeMode.system, child: Text('System')),
          DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
          DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
        ],
        onChanged: (ThemeMode? value) {
          if (value != null) {
            SettingsProvider.instance.setThemeMode(value);
            final themeSettings = ThemeProvider.of(context).settings.value;
            final newThemeSettings = ThemeSettings(
                sourceColor: themeSettings.sourceColor, themeMode: value);
            ThemeSettingsChange(settings: newThemeSettings).dispatch(context);
          }
        });
  }
}
