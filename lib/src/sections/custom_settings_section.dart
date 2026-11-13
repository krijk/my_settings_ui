import 'package:material_ui/material_ui.dart';
import '/src/sections/abstract_settings_section.dart';

class CustomSettingsSection extends AbstractSettingsSection {
  const CustomSettingsSection({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
