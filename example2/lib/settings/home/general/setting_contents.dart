import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';
import 'package:mylib01/lib.dart';

import '/globals.dart';
import '/src/navigation.dart';

const String pageTitle = 'General';

enum Category {
  common,
  account,
  security,
  misc,
  ;

  String get label {
    return name.capitalize();
  }

  Icon? get icon {
    return null;
  }

  static Category getEnum(String label) {
    for (final Category e in values) {
      if (e.name == label.toLowerCase()) {
        return e;
      }
    }
    return Category.common;
  }
}

class SettingTile extends AbstractSettingsTile {
  const SettingTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class SettingsGeneral2 extends StatefulWidget {
  const SettingsGeneral2({super.key});
  @override
  State<SettingsGeneral2> createState() => SettingsGeneral2State();
}

class SettingsGeneral2State extends State<SettingsGeneral2> {
  Category selected = Category.common;

  final Map<DevicePlatform, String> platformsMap = <DevicePlatform, String>{
    DevicePlatform.device: 'Default',
    DevicePlatform.android: 'Android',
    DevicePlatform.iOS: 'iOS',
    DevicePlatform.web: 'Web',
    DevicePlatform.fuchsia: 'Fuchsia',
    DevicePlatform.linux: 'Linux',
    DevicePlatform.macOS: 'MacOS',
    DevicePlatform.windows: 'Windows',
  };
  DevicePlatform selectedPlatform = DevicePlatform.device;
  bool useCustomTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(pageTitle)),
      body: (MediaQuery.of(context).size.width > gScreenLarge) ? layoutLarge(context) : layoutSmall(context),
    );
  }

  Widget layoutSmall(BuildContext context) {
    return SettingsList(
      sections: settingContents(context),
    );
  }

  Widget layoutLarge(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: settingMenu(context),
        ),
        const VerticalDivider(width: 1),
        Flexible(
          flex: 5,
          child: settingContent1(context, selected),
        ),
      ],
    );
  }

  Widget settingMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: menuContents(context),
          ),
        ),
        const Align(
          alignment: FractionalOffset.bottomCenter,
          child: RestoreSettings(),
        ),
      ],
    );
  }

  List<Widget> menuContents(BuildContext context) {
    final List<Widget> list = <Widget>[];
    for (final Category e in Category.values) {
      list.add(menuItem(context, e));
    }
    return list;
  }

  ListTile menuItem(BuildContext context, Category category) {
    final ListTile item = ListTile(
      leading: category.icon,
      title: Text(category.label),
      selected: selected == category,
      onTap: () {
        setState(() {
          selected = category;
        });
      },
    );
    return item;
  }

  List<AbstractSettingsSection> settingContents(BuildContext context) {
    final List<AbstractSettingsSection> list = <AbstractSettingsSection>[];
    for (final Category e in Category.values) {
      list.add(getSettingSection(context, e, withTitle: true));
    }
    return list;
  }

  Widget settingContent1(BuildContext context, Category category, {bool withTitle = false}) {
    return SettingsList(
      sections: <AbstractSettingsSection>[
        SettingsSection(
          title: withTitle ? Text(category.label) : null,
          tiles: getTiles(context, category),
        ),
      ],
    );
  }

  SettingsSection getSettingSection(
    BuildContext context,
    Category category, {
    bool withTitle = false,
  }) {
    return SettingsSection(
      title: withTitle ? Text(category.label) : null,
      tiles: getTiles(context, category),
    );
  }

  List<AbstractSettingsTile> getTiles(BuildContext context, Category category) {
    switch (category) {
      case Category.common:
        return <AbstractSettingsTile>[
          SettingsTile.navigation(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            value: const Text('English'),
          ),
          SettingsTile.navigation(
            leading: const Icon(Icons.cloud_outlined),
            title: const Text('Environment'),
            value: const Text('Production'),
          ),
          SettingsTile.navigation(
            leading: const Icon(Icons.devices_other),
            title: const Text('Platform'),
            onPressed: (BuildContext context) async {
              final DevicePlatform? platform = await Navigation.navigateTo<DevicePlatform>(
                context: context,
                style: NavigationRouteStyle.material,
                screen: PlatformPickerScreen(
                  platform: selectedPlatform,
                  platforms: platformsMap,
                ),
              );

              if (platform != null) {
                setState(() {
                  selectedPlatform = platform;
                });
              }
            },
            value: Text(platformsMap[selectedPlatform]!),
          ),
          SettingsTile.switchTile(
            onToggle: (bool value) {
              setState(() {
                useCustomTheme = value;
              });
            },
            initialValue: useCustomTheme,
            leading: const Icon(Icons.format_paint),
            title: const Text('Enable custom theme'),
          ),
        ];
      case Category.account:
        return <AbstractSettingsTile>[
          SettingsTile.navigation(
            leading: const Icon(Icons.phone),
            title: const Text('Phone number'),
          ),
          SettingsTile.navigation(
            leading: const Icon(Icons.mail),
            title: const Text('Email'),
            enabled: false,
          ),
          SettingsTile.navigation(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
          ),
        ];
      case Category.security:
        return <AbstractSettingsTile>[
          SettingsTile.switchTile(
            onToggle: (_) {},
            initialValue: true,
            leading: const Icon(Icons.phonelink_lock),
            title: const Text('Lock app in background'),
          ),
          SettingsTile.switchTile(
            onToggle: (_) {},
            initialValue: true,
            leading: const Icon(Icons.fingerprint),
            title: const Text('Use fingerprint'),
            description: const Text(
              'Allow application to access stored fingerprint IDs',
            ),
          ),
          SettingsTile.switchTile(
            onToggle: (_) {},
            initialValue: true,
            leading: const Icon(Icons.lock),
            title: const Text('Change password'),
          ),
          SettingsTile.switchTile(
            onToggle: (_) {},
            initialValue: true,
            leading: const Icon(Icons.notifications_active),
            title: const Text('Enable notifications'),
          ),
        ];
      case Category.misc:
        return <AbstractSettingsTile>[
          SettingsTile.navigation(
            leading: const Icon(Icons.description),
            title: const Text('Terms of Service'),
          ),
          SettingsTile.navigation(
            leading: const Icon(Icons.collections_bookmark),
            title: const Text('Open source license'),
          ),
        ];
    }
  }
}

class RestoreSettings extends AbstractSettingsTile {
  const RestoreSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore Settings'),
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

class PlatformPickerScreen extends StatelessWidget {
  const PlatformPickerScreen({
    super.key,
    required this.platform,
    required this.platforms,
  });

  final DevicePlatform platform;
  final Map<DevicePlatform, String> platforms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Platforms')),
      body: SettingsList(
        platform: platform,
        sections: <AbstractSettingsSection>[
          SettingsSection(
            title: const Text('Select the platform you want'),
            tiles: platforms.keys.map((DevicePlatform e) {
              final String? platform = platforms[e];

              return SettingsTile(
                title: Text(platform!),
                onPressed: (_) {
                  Navigator.of(context).pop(e);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
