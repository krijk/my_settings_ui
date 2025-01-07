import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';

import '/src/navigation.dart';
import 'setting_contents.dart';

class SettingTileTest extends AbstractSettingsTile {
  const SettingTileTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsTile.navigation(
      title: const Text('Test'),
      leading: const Icon(Icons.pest_control),
      description: const Text('Settings Tile Test'),
      onPressed: (BuildContext context) {
        Navigation.navigateTo(
          context: context,
          screen: const SettingTestContents(),
          style: NavigationRouteStyle.material,
        );
      },
    );
  }
}
