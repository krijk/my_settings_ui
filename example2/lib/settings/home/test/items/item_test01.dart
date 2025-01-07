import 'package:flutter/material.dart';
import 'package:my_settings_ui/my_settings_ui.dart';

class ItemTest01 extends AbstractSettingsTile {
  const ItemTest01({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text('test01');

  }
}
