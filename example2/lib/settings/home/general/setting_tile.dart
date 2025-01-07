import 'package:flutter/cupertino.dart';
import 'package:my_settings_ui/my_settings_ui.dart';

import '/src/navigation.dart';
import 'setting_contents.dart';

class SettingTileGeneral extends AbstractSettingsTile {
  const SettingTileGeneral({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SettingsTile.navigation(
      title: const Text('Abstract settings screen'),
      leading: const Icon(CupertinoIcons.wrench),
      description: const Text("UI created to show plugin's possibilities"),
      onPressed: (BuildContext context) {
        Navigation.navigateTo(
          context: context,
          screen: const SettingsGeneral2(),
          style: NavigationRouteStyle.material,
        );
      },
    );
  }
}
