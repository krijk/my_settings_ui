import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';
import 'package:mylib01/lib.dart';

import '/globals.dart';
import '../../settings/controller.dart';
import 'general/setting_tile.dart';
import 'test/setting_tile.dart';
import 'theme/setting_tile.dart';

const String pageTitle = 'Settings';

enum Category {
  general,
  theme,
  test,
  ;

  String get label {
    return name.capitalize();
  }

  Icon? get icon {
    return null;
  }

  AbstractSettingsTile getTile() {
    switch (this) {
      case Category.general:
        return const SettingTileGeneral();
      case Category.theme:
        return const SettingTileTheme();
      case Category.test:
        return const SettingTileTest();
    }
  }

  SettingsSection getSettingSection({bool withTitle = false}) {
    return SettingsSection(
      title: withTitle ? Text(label) : null,
      tiles: <AbstractSettingsTile>[
        getTile(),
      ],
    );
  }
}

class PageSettings extends ConsumerStatefulWidget {
  const PageSettings({super.key});

  @override
  PageSettingsState createState() => PageSettingsState();
}

class PageSettingsState extends ConsumerState<PageSettings> {
  Category selected = Category.general;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(pageTitle)),
      body: (MediaQuery.of(context).size.width > gScreenLarge) ? layoutLarge(context) : layoutSmall(context),
    );
  }

  Widget layoutSmall(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SettingsList(
            sections: settingContents(),
          ),
        ),
        const RestoreSettings(),
      ],
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
          child: settingContent1(selected),
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
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: RestoreSettings(
            category: selected,
          ),
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

  List<AbstractSettingsSection> settingContents() {
    final List<AbstractSettingsSection> list = <AbstractSettingsSection>[];
    for (final Category e in Category.values) {
      list.add(e.getSettingSection(withTitle: true));
    }
    return list;
  }

  Widget settingContent1(Category category, {bool withTitle = false}) {
    return SettingsList(
      sections: <AbstractSettingsSection>[
        SettingsSection(
          title: withTitle ? Text(category.label) : null,
          tiles: <AbstractSettingsTile>[
            category.getTile(),
          ],
        ),
      ],
    );
  }
}

class RestoreSettings extends AbstractSettingsTile {
  final Category? category;

  const RestoreSettings({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore Settings'),
        onPressed: () => openDialog(context, ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  void openDialog(BuildContext context, WidgetRef ref) {
    const double padding = 8;
    String label = '';
    switch (category) {
      case Category.general:
      case Category.theme:
      case Category.test:
        label = 'Restore ${category!.label} settings?';
        break;
      case null:
        label = 'Restore all settings?';
        break;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(padding),
          title: Text(label),
          // content: const SizedBox(
          //   width: double.maxFinite,
          //   child: Text('Restore all settings?'),
          // ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                final SettingsController settingsController = ref.read(settingProvider);
                switch (category) {
                  case Category.general:
                    break;
                  case Category.theme:
                    settingsController.restoreTheme();
                    break;
                  case Category.test:
                    break;
                  case null:
                    settingsController.restoreAll();
                    break;
                }
                Navigator.pop(context, 'Yes');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
