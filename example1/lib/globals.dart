import 'package:flutter_riverpod/legacy.dart';
import '/settings/controller.dart';

final settingProvider = ChangeNotifierProvider<SettingsController>((ref) => SettingsController());
