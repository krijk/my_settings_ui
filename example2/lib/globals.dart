// ignore_for_file: always_specify_types
import 'package:example2/src/searcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/settings/controller.dart';
import 'contents/selection.dart';

/// MaterialApp title
/// A one-line description used by the device to identify the app for the user.
/// Shown on the Web Page TAB
const String applicationTitle = 'settingEx02';

/// AppBar title
const String appBarTitle = 'setting ex2';

const double gScreenLarge = 720;

final settingProvider = ChangeNotifierProvider<SettingsController>((ref) => SettingsController());
final searchProvider = ChangeNotifierProvider<SearchNotifier>((ref) => SearchNotifier());
final selectedProvider = ChangeNotifierProvider<SelectedNotifier>((ref) => SelectedNotifier());
