import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';

const bool initialAnimateExpressions = true;
const TextDirection initialTextDirection = TextDirection.ltr;

enum PrefKey {
  animateExpansions,
  textDirection,
  ;

  String get key => toString();

  Future<dynamic> get preference async {
    switch (this) {
      case PrefKey.animateExpansions:
        return Pref.getBool(
          key,
        );
      case PrefKey.textDirection:
        return TextDirection.ltr;
    }
  }

  set preference(dynamic value) {
    switch (this) {
      default:
        break;
    }
  }
}

class SettingsController with ChangeNotifier {
  SettingsState get state => _state;
  late SettingsState _state;

  SettingsController() {
    _state = SettingsState();
  }

  Future<void> retrievePreference() async {
    final bool animateExpansions = await PrefKey.animateExpansions.preference;
    final TextDirection textDirection = await PrefKey.textDirection.preference;

    final SettingsState state = SettingsState();
    _state = state.copyWith(
      animateExpansions: animateExpansions,
      textDirection: textDirection,
    );
  }
}

class SettingsState {
  final bool animateExpansions;
  final TextDirection textDirection;

  SettingsState({
    this.animateExpansions = initialAnimateExpressions,
    this.textDirection = initialTextDirection,
  });

  SettingsState copyWith({
    bool? animateExpansions,
    TextDirection? textDirection,
  }) {
    return SettingsState(
      animateExpansions: animateExpansions ?? this.animateExpansions,
      textDirection: textDirection ?? this.textDirection,
    );
  }
}
