import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/contents/selection.dart';

//* Animate Expand & Collapse --------------------------------------------------

class AnimateExpansions extends ConsumerWidget {
  const AnimateExpansions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool animatedExpansions = ref.watch(settingProvider).state.animateExpansions;
    final Selection selected = ref.watch(selectedProvider).value;

    bool enable = true;
    switch(selected){
      case Selection.minimal1:
      case Selection.filterable:
        enable = false;
        break;
      default:
        break;
    }

    return SwitchListTile(
      title: const Text('Animate Expand & Collapse'),
      value: animatedExpansions,
      onChanged: enable ? (bool value) {
        ref.read(settingProvider).updateAnimateExpansions(value: value);
      } : null,
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
    );
  }
}
