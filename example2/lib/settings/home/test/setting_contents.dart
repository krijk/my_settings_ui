import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';
import 'package:mylib01/lib.dart';

import '/globals.dart';
import 'items/item_test01.dart';
import 'items/item_test02.dart';

const String pageTitle = 'App';

enum Category {
  test01,
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
    return Category.test01;
  }
}

class SettingTestContents extends StatefulWidget {
  const SettingTestContents({super.key});
  @override
  State<SettingTestContents> createState() => SettingTestContentsState();
}

class SettingTestContentsState extends State<SettingTestContents> {
  Category selected = Category.test01;

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
      case Category.test01:
        return <AbstractSettingsTile>[
          const ItemTest01(),
          const ItemTest02(child: Text('test2'),),
        ];
    }
  }
}
