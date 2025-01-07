import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';
import 'package:mylib01/lib.dart';

import '/globals.dart';
import '/settings/controller.dart';
import 'items/color_selector2.dart';
import 'items/tree_theme.dart';

const String pageTitle = 'Theme';

enum Category {
  common,
  tree,
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

class SettingTheme4 extends ConsumerStatefulWidget {
  const SettingTheme4({super.key});
  @override
  SettingTheme4State createState() => SettingTheme4State();
}

class SettingTheme4State extends ConsumerState<SettingTheme4> {
  Category selected = Category.common;

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
            sections: settingContents(context),
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
    final IndentType indentType = ref.watch(settingProvider).state.indentType;
    switch (category) {
      case Category.common:
        return <AbstractSettingsTile>[const ColorSelector2()];
      case Category.tree:
        return <AbstractSettingsTile>[
          const TreeAnimation(),
          const Indent(),
          const IndentGuideType(),
          if (indentType != IndentType.blank) ...<AbstractSettingsTile>[
            if (indentType == IndentType.connectingLines) ...<AbstractSettingsTile>[
              const RoundedConnections(),
            ],
            const LineThickness(),
            const LineOrigin(),
          ],
        ];
    }
  }
}

class RestoreSettings extends AbstractSettingsTile {
  final Category? category;

  const RestoreSettings({this.category, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore Settings'),
        onPressed: (){
          final SettingsController settingsController = ref.read(settingProvider);
          switch(category){
            case Category.common:
              settingsController.restoreThemeCommon();
              break;
            case Category.tree:
              settingsController.restoreThemeTree();
              break;
            case null:
              settingsController.restoreTheme();
              break;
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
