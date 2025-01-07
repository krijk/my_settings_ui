import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';

import '/settings/controller.dart';
import '/settings/helpers.dart';

class TreeAnimation extends AbstractSettingsTile {
  const TreeAnimation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool animatedExpansions = ref.watch(settingProvider).state.animateExpansions;

    return SettingsTile.switchTile(
      onToggle: (bool value) => updateTreeAnimation(ref, value: value),
      initialValue: animatedExpansions,
      leading: const Icon(Icons.animation),
      title: const Text('Animate Expand & Collapse'),
    );
  }

  void updateTreeAnimation(WidgetRef ref, {required bool value}) {
    ref.read(settingProvider).updateAnimateExpansions(value: value);
  }
}

//* Indent ---------------------------------------------------------------------

class Indent extends AbstractSettingsTile {
  const Indent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double indent = ref.watch(settingProvider).state.indent;
    /*
    FIXME:
    The following assertion was thrown building SliderListTile(dirty):
Value 0.0 is not between minimum 0.1 and maximum 64.0
'package:flutter/src/material/slider.dart':
Failed assertion: line 194 pos 15: 'value >= min && value <= max'
     */
    return SliderListTile(
      title: 'Indent per Level',
      value: indent,
      max: 64.0,
      onChanged: (double value) => ref.read(settingProvider).updateIndent(value.roundToDouble()),
    );
  }
}

//* Indent Guide Type ----------------------------------------------------------

class IndentGuideType extends AbstractSettingsTile {
  const IndentGuideType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IndentType indentType = ref.watch(settingProvider).state.indentType;

    return ExpansionTile(
      title: const Text('Indent Guide Type'),
      subtitle: Text(
        indentType.title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      shape: const RoundedRectangleBorder(/*side: BorderSide.none*/),
      children: <Widget>[
        for (final IndentType type in IndentType.allExcept(indentType))
          ListTile(
            title: Text(type.title),
            onTap: () {
              ref.read(settingProvider).updateIndentType(type);
            },
            dense: true,
          ),
      ],
    );
  }
}

//* Rounded Line Connections ---------------------------------------------------

class RoundedConnections extends AbstractSettingsTile {
  const RoundedConnections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool roundedConnections = ref.watch(settingProvider).state.roundedCorners;

    return SwitchListTile(
      title: const Text('Rounded Line Connections'),
      value: roundedConnections,
      onChanged: (bool value) {
        ref.read(settingProvider).updateRoundedCorners(value: value);
      },
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
    );
  }
}

//* Line Thickness -------------------------------------------------------------

class LineThickness extends AbstractSettingsTile {
  const LineThickness({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double thickness = ref.watch(settingProvider).state.lineThickness;

    return SliderListTile(
      title: 'Line Thickness',
      value: thickness,
      // min: 0.0,
      max: 8.0,
      divisions: 16,
      onChanged: (double value) {
        ref.read(settingProvider).updateLineThickness(value);
      },
    );
  }
}

//* Line Origin ----------------------------------------------------------------

class LineOrigin extends AbstractSettingsTile {
  const LineOrigin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double origin = ref.watch(settingProvider).state.lineOrigin;

    return SliderListTile(
      title: 'Line Origin',
      value: origin,
      // min: 0.0,
      // max: 1.0,
      divisions: 10,
      onChanged: (double value) {
        ref.read(settingProvider).updateLineOrigin(value);
      },
    );
  }
}

//* Restore Theme Settings -------------------------------------------------------

class RestoreThemeSettings extends AbstractSettingsTile {
  const RestoreThemeSettings({super.key});

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
