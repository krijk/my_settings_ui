import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';

//* Filter Capital --------------------------------------------------

class SearchFilterCapital1 extends AbstractSettingsTile {
  const SearchFilterCapital1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool filterCapital = ref.watch(settingProvider).state.filterCapital;

    return SwitchListTile(
      title: const Text('Filter case sensitive'),
      subtitle: const Text('Distinguish between upper and lower case letters'),
      value: filterCapital,
      onChanged: (bool value) {
        ref.read(settingProvider).updateFilterCapital(value: value);
      },
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
    );
  }
}
