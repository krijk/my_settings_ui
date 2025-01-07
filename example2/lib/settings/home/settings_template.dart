import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';
import 'package:mylib01/lib.dart';

import '/globals.dart';
import '../../../settings/controller.dart';

const String pageTitle = 'Settings';

enum Category {
  item1,
  item2,
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
    return Category.item1;
  }
}

class SettingTile extends AbstractSettingsTile {
  const SettingTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class PageSettingsTemplate extends StatefulWidget {
  const PageSettingsTemplate({super.key});
  @override
  State<PageSettingsTemplate> createState() => PageSettingsTemplateState();
}

class PageSettingsTemplateState extends State<PageSettingsTemplate> {
  Category selected = Category.item1;

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

  List<AbstractSettingsTile> getTiles(
    BuildContext context,
    Category category,
  ) {
    switch (category) {
      case Category.item1:
        return <AbstractSettingsTile>[const SettingTile()];
      case Category.item2:
        return <AbstractSettingsTile>[const SettingTile()];
    }
  }
}

class RestoreSettings extends AbstractSettingsTile {
  const RestoreSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final SettingsController settingsController = ref.read(settingProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore Settings'),
        onPressed: () => settingsController.restoreAll(), // TODO
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
