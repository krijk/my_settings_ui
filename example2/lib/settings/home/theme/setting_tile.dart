import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';

import '/src/navigation.dart';
import 'setting_contents.dart';

class SettingTileTheme extends AbstractSettingsTile {
  const SettingTileTheme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsTile.navigation(
      title: const Text('App theme'),
      leading: const Icon(Icons.color_lens),
      description: const Text('UI themes'),
      onPressed: (BuildContext context) {
        Navigation.navigateTo(
          context: context,
          screen: const SettingTheme4(),
          style: NavigationRouteStyle.material,
        );
      },
    );
  }
}
