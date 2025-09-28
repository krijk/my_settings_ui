import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';

const Color initialColor = Colors.grey;
const bool initialAnimateExpressions = true;
const Brightness initialBrightness = Brightness.dark;
const double initialIndent = 40.0;
const IndentType initialIndentType = IndentType.connectingLines;
const double initialLineOrigin = 0.5;
const double initialLineThickness = 2.0;
const bool initialRoundedCorners = false;
const TextDirection initialTextDirection = TextDirection.ltr;
const bool initialFilterCapital = false;

/// Preference key
enum PrefKey {
  /// Theme
  // common
  color,
  // tree
  animateExpansions,
  brightness,
  indent,
  indentType,
  lineOrigin,
  lineThickness,
  roundedCorners,
  textDirection,
  filterCapital,
  ;

  String get key => toString();

  Future<dynamic> get preference async {
    switch (this) {
      case PrefKey.animateExpansions:
        return Pref.getBool(
          key,
        );
      case PrefKey.brightness:
        final String strBrightness = await Pref.getString(key, initialBrightness.name);
        return BrightnessEx.getEnumByName(strBrightness);
      case PrefKey.color:
        final String colorCode = await Pref.getString(key, initialColor.toHex(withAlpha: true));
        return Color(int.parse(colorCode, radix: 16));
      case PrefKey.indent:
        return Pref.getDouble(key, initialIndent);
      case PrefKey.indentType:
        return IndentType.getEnumByName(await Pref.getString(key, initialIndentType.name));
      case PrefKey.lineOrigin:
        return Pref.getDouble(key, initialLineOrigin);
      case PrefKey.lineThickness:
        return Pref.getDouble(key, initialLineThickness);
      case PrefKey.roundedCorners:
        return Pref.getBool(
          key,
          defaultVal: initialRoundedCorners,
        );
      case PrefKey.textDirection:
        return TextDirection.ltr;
      case PrefKey.filterCapital:
        return Pref.getBool(
          key,
          defaultVal: initialFilterCapital,
        );
    }
  }

  set preference(dynamic value) {
    switch (this) {
      case PrefKey.animateExpansions:
        Pref.setBool(key, value: value);
        break;
      case PrefKey.brightness:
        Pref.setString(key, (value as Brightness).name);
        break;
      case PrefKey.color:
        Pref.setString(key, (value as Color).toHex(withAlpha: true));
        break;
      case PrefKey.indent:
        Pref.setDouble(key, value);
        break;
      case PrefKey.indentType:
        Pref.setString(key, (value as IndentType).name);
        break;
      case PrefKey.lineOrigin:
        Pref.setDouble(key, value);
        break;
      case PrefKey.lineThickness:
        Pref.setDouble(key, value);
        break;
      case PrefKey.roundedCorners:
        Pref.setBool(key, value: value);
        break;
      case PrefKey.filterCapital:
        Pref.setBool(key, value: value);
        break;
      default:
        break;
    }
  }
}

extension BrightnessEx on Brightness {
  /// Get enum name using extension
  String get name {
    return toString().split('.').last;
  }

  /// Get enum by its name
  /// the name could be 'system'
  static Brightness? getEnumByName(String name) {
    for (final Brightness e in Brightness.values) {
      if (e.name == name) {
        return e;
      }
    }
    return Brightness.dark;
  }
}

enum IndentType {
  connectingLines('Connecting Lines'),
  scopingLines('Scoping Lines'),
  blank('Blank');

  final String title;

  const IndentType(this.title);

  static Iterable<IndentType> allExcept(IndentType type) {
    return values.where((IndentType element) => element != type);
  }

  String get name {
    return toString().split('.').last;
  }

  static IndentType? getEnumByName(String name) {
    for (final IndentType e in IndentType.values) {
      if (e.name == name) {
        return e;
      }
    }
    return null;
  }
}

class SettingsState {
  SettingsState({
    this.animateExpansions = initialAnimateExpressions,
    this.brightness = initialBrightness,
    this.color = initialColor,
    this.indent = initialIndent,
    this.indentType = initialIndentType,
    this.lineOrigin = initialLineOrigin,
    this.lineThickness = initialLineThickness,
    this.roundedCorners = initialRoundedCorners,
    this.textDirection = initialTextDirection,
    this.filterCapital = false,
  });

  final bool animateExpansions;
  final Brightness brightness;
  final Color color;
  final double indent;
  final IndentType indentType;
  final double lineOrigin;
  final double lineThickness;
  final bool roundedCorners;
  final TextDirection textDirection;
  final bool filterCapital;

  SettingsState copyWith({
    bool? animateExpansions,
    Brightness? brightness,
    Color? color,
    double? indent,
    IndentType? indentType,
    double? lineOrigin,
    double? lineThickness,
    bool? roundedCorners,
    TextDirection? textDirection,
    bool? filterCapital,
  }) {
    return SettingsState(
      animateExpansions: animateExpansions ?? this.animateExpansions,
      brightness: brightness ?? this.brightness,
      color: color ?? this.color,
      indent: indent ?? this.indent,
      indentType: indentType ?? this.indentType,
      lineOrigin: lineOrigin ?? this.lineOrigin,
      lineThickness: lineThickness ?? this.lineThickness,
      roundedCorners: roundedCorners ?? this.roundedCorners,
      textDirection: textDirection ?? this.textDirection,
      filterCapital: filterCapital ?? this.filterCapital,
    );
  }
}

class SettingsController with ChangeNotifier {
  SettingsController() {
    _state = SettingsState();
  }

  SettingsState get state => _state;
  late SettingsState _state;

  @protected
  set state(SettingsState state) {
    _state = state;
    notifyListeners();
  }

  /// Retrieve preference settings
  Future<void> retrievePreference() async {
    final bool animateExpansions = await PrefKey.animateExpansions.preference;
    final Brightness brightness = await PrefKey.brightness.preference;
    final Color color = await PrefKey.color.preference;
    final double indent = await PrefKey.indent.preference;
    final IndentType indentType = await PrefKey.indentType.preference;
    final double lineOrigin = await PrefKey.lineOrigin.preference;
    final double lineThickness = await PrefKey.lineThickness.preference;
    final bool roundedCorners = await PrefKey.roundedCorners.preference;
    final TextDirection textDirection = await PrefKey.textDirection.preference;
    final bool filterCapital = await PrefKey.filterCapital.preference;

    final SettingsState state = SettingsState();
    _state = state.copyWith(
      animateExpansions: animateExpansions,
      // brightness: brightness,
      color: color,
      indent: indent,
      indentType: indentType,
      lineOrigin: lineOrigin,
      lineThickness: lineThickness,
      roundedCorners: roundedCorners,
      textDirection: textDirection,
      filterCapital: filterCapital,
    );
  }

  Future<void> storePreference() async {
    PrefKey.animateExpansions.preference = state.animateExpansions;
    PrefKey.brightness.preference = state.brightness;
    PrefKey.color.preference = state.color;
    PrefKey.indent.preference = state.indent;
    PrefKey.indentType.preference = state.indentType;
    PrefKey.lineOrigin.preference = state.lineOrigin;
    PrefKey.lineThickness.preference = state.lineThickness;
    PrefKey.roundedCorners.preference = state.roundedCorners;
    PrefKey.filterCapital.preference = state.filterCapital;
  }

  void restoreAll() {
    restoreSearch();
    restoreThemeCommon();
    restoreThemeTree();
  }

  void restoreSearch() {
    state = state.copyWith(
      filterCapital: initialFilterCapital,
    );
    PrefKey.filterCapital.preference = state.filterCapital;
  }

  void restoreTheme() {
    restoreThemeCommon();
    restoreThemeTree();
  }

  void restoreThemeCommon() {
    state = state.copyWith(
      color: initialColor,
    );
    PrefKey.color.preference = state.color;
  }

  void restoreThemeTree() {
    state = state.copyWith(
      animateExpansions: initialAnimateExpressions,
      brightness: initialBrightness,
      indent: initialIndent,
      indentType: initialIndentType,
      lineOrigin: initialLineOrigin,
      lineThickness: initialLineThickness,
      roundedCorners: initialRoundedCorners,
    );

    PrefKey.animateExpansions.preference = state.animateExpansions;
    PrefKey.brightness.preference = state.brightness;
    PrefKey.indent.preference = state.indent;
    PrefKey.indentType.preference = state.indentType;
    PrefKey.lineOrigin.preference = state.lineOrigin;
    PrefKey.lineThickness.preference = state.lineThickness;
    PrefKey.roundedCorners.preference = state.roundedCorners;
  }

  void updateAnimateExpansions({bool value = false}) {
    if (value == state.animateExpansions) return;
    state = state.copyWith(animateExpansions: value);
    PrefKey.animateExpansions.preference = value;
  }

  void updateBrightness(Brightness value) {
    if (state.brightness == value) return;
    state = state.copyWith(brightness: value);
    PrefKey.brightness.preference = value;
  }

  void updateColor(Color value) {
    if (state.color == value) return;
    state = state.copyWith(color: value);
    PrefKey.color.preference = value;
  }

  void updateIndent(double value) {
    if (state.indent == value) return;
    state = state.copyWith(indent: value);
    PrefKey.indent.preference = value;
  }

  void updateIndentType(IndentType value) {
    if (state.indentType == value) return;
    state = state.copyWith(indentType: value);
    PrefKey.indentType.preference = value;
  }

  void updateLineOrigin(double value) {
    if (state.lineOrigin == value) return;
    state = state.copyWith(lineOrigin: value);
    PrefKey.lineOrigin.preference = value;
  }

  void updateLineThickness(double value) {
    if (state.lineThickness == value) return;
    state = state.copyWith(lineThickness: value);
    PrefKey.lineThickness.preference = value;
  }

  void updateRoundedCorners({bool value = false}) {
    if (state.roundedCorners == value) return;
    state = state.copyWith(roundedCorners: value);
    PrefKey.roundedCorners.preference = value;
  }

  void updateTextDirection(TextDirection value) {
    if (state.textDirection == value) return;
    state = state.copyWith(textDirection: value);
    PrefKey.textDirection.preference = value;
  }

  void updateFilterCapital({bool value = false}) {
    if (value == state.filterCapital) return;
    state = state.copyWith(filterCapital: value);
    PrefKey.filterCapital.preference = value;
  }
}
