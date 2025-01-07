import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';

import '/src/navigation.dart';
import '../home/page_settings.dart';
import 'items/app_introduction.dart';
import 'items/contents_selector.dart';
import 'items/search_filter_capital1.dart';
import 'items/search_filter_capital2.dart';

class SettingsCategories extends ConsumerWidget {
  const SettingsCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> categories = <Widget>[
      const ContentsSelector(),
      const AppIntroduction(),
      const SearchFilterCapital1(), // FIXME
      getSettings(context),
    ];

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            itemCount: categories.length,
            itemBuilder: (_, int index) => categories[index],
            separatorBuilder: (_, __) => const Divider(height: 1),
          ),
        ),
        const ButtonSettingScreen(),
      ],
    );
  }

  Widget getSettings(BuildContext context) {
    final ThemeData themeData = ThemeData.light(useMaterial3: false);
    final SettingsThemeData settingsThemeData = SettingsThemeData(settingsListBackground: themeData.drawerTheme.scrimColor);
    return SettingsList(
      shrinkWrap: true,
      lightTheme: settingsThemeData,
      darkTheme: settingsThemeData,
      sections: const <AbstractSettingsSection>[
        SettingsSection(
          tiles: <AbstractSettingsTile>[
            SearchFilterCapital2(),
          ],
        ),
      ],
    );
  }

  void item2() {}
}

//* Restore All Settings -------------------------------------------------------

class RestoreAllSettings extends ConsumerWidget {
  const RestoreAllSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore'),
        onPressed: () => ref.read(settingProvider).restoreAll(),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

// Button to the Setting Screen
class ButtonSettingScreen extends StatelessWidget {
  const ButtonSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.settings),
        label: const Text('Settings'),
        onPressed: () => navigate(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  void navigate(BuildContext context) {
    Navigation.navigateTo(
      context: context,
      screen: const PageSettings(),
      style: NavigationRouteStyle.material,
    );
  }
}
