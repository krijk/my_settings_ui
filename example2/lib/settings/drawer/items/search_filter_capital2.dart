import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';

//* Filter Capital --------------------------------------------------

class SearchFilterCapital2 extends AbstractSettingsTile {
  const SearchFilterCapital2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool filterCapital = ref.watch(settingProvider).state.filterCapital;

    return SettingsTile.switchTile(
      onToggle: (bool value) {
        // context.read<SettingsController>().updateFilterCapital(value: value);
      },
      initialValue: filterCapital,
      leading: const Icon(Icons.filter_alt),
      title: const Text('Search Filter Capital'),
    );
  }
}
