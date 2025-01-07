import 'package:flutter/cupertino.dart';
import '/src/utils/platform_utils.dart';
import '/src/utils/settings_theme.dart';

class ThemeProvider {
  static SettingsThemeData getTheme({
    required BuildContext context,
    required DevicePlatform platform,
    required Brightness brightness,
  }) {
    switch (platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
        return _androidTheme(context: context, brightness: brightness);
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return _iosTheme(context: context, brightness: brightness);
      case DevicePlatform.web:
        return _webTheme(context: context, brightness: brightness);
      case DevicePlatform.device:
        throw Exception(
          "You can't use the DevicePlatform.device in this context. "
          'Incorrect platform: ThemeProvider.getTheme',
        );
    }
  }

  static SettingsThemeData _androidTheme({
    required BuildContext context,
    required Brightness brightness,
  }) {
    final Color lightLeadingIconsColor = Color.fromARGB(255, 70, 70, 70);
    final Color darkLeadingIconsColor = Color.fromARGB(255, 197, 197, 197);

    final Color lightSettingsListBackground = Color.fromRGBO(240, 240, 240, 1);
    final Color darkSettingsListBackground = Color.fromRGBO(27, 27, 27, 1);

    final Color lightSettingsTitleColor = Color.fromRGBO(11, 87, 208, 1);
    final Color darkSettingsTitleColor = Color.fromRGBO(211, 227, 253, 1);

    final Color lightTileHighlightColor = Color.fromARGB(255, 220, 220, 220);
    final Color darkTileHighlightColor = Color.fromARGB(255, 46, 46, 46);

    final Color lightSettingsTileTextColor = Color.fromARGB(255, 27, 27, 27);
    final Color darkSettingsTileTextColor = Color.fromARGB(255, 240, 240, 240);

    final Color lightInactiveTitleColor = Color.fromARGB(255, 146, 144, 148);
    final Color darkInactiveTitleColor = Color.fromARGB(255, 118, 117, 122);

    final Color lightInactiveSubtitleColor = Color.fromARGB(255, 197, 196, 201);
    final Color darkInactiveSubtitleColor = Color.fromARGB(255, 71, 70, 74);

    final Color lightTileDescriptionTextColor = Color.fromARGB(255, 70, 70, 70);
    final Color darkTileDescriptionTextColor = Color.fromARGB(255, 198, 198, 198);

    final bool isLight = brightness == Brightness.light;

    final Color listBackground =
        isLight ? lightSettingsListBackground : darkSettingsListBackground;

    final Color titleTextColor =
        isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

    final Color settingsTileTextColor =
        isLight ? lightSettingsTileTextColor : darkSettingsTileTextColor;

    final Color tileHighlightColor =
        isLight ? lightTileHighlightColor : darkTileHighlightColor;

    final Color tileDescriptionTextColor =
        isLight ? lightTileDescriptionTextColor : darkTileDescriptionTextColor;

    final Color leadingIconsColor =
        isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

    final Color inactiveTitleColor =
        isLight ? lightInactiveTitleColor : darkInactiveTitleColor;

    final Color inactiveSubtitleColor =
        isLight ? lightInactiveSubtitleColor : darkInactiveSubtitleColor;

    return SettingsThemeData(
      tileHighlightColor: tileHighlightColor,
      settingsListBackground: listBackground,
      titleTextColor: titleTextColor,
      settingsTileTextColor: settingsTileTextColor,
      tileDescriptionTextColor: tileDescriptionTextColor,
      leadingIconsColor: leadingIconsColor,
      inactiveTitleColor: inactiveTitleColor,
      inactiveSubtitleColor: inactiveSubtitleColor,
    );
  }

  static SettingsThemeData _iosTheme({
    required BuildContext context,
    required Brightness brightness,
  }) {
    final Color lightSettingsListBackground = Color.fromRGBO(242, 242, 247, 1);
    final Color darkSettingsListBackground = CupertinoColors.black;

    final Color lightSettingSectionColor = CupertinoColors.white;
    final Color darkSettingSectionColor = Color.fromARGB(255, 28, 28, 30);

    final Color lightSettingsTitleColor = Color.fromRGBO(109, 109, 114, 1);
    final CupertinoDynamicColor darkSettingsTitleColor = CupertinoColors.systemGrey;

    final Color lightDividerColor = Color.fromARGB(255, 238, 238, 238);
    final Color darkDividerColor = Color.fromARGB(255, 40, 40, 42);

    final Color lightTrailingTextColor = Color.fromARGB(255, 138, 138, 142);
    final Color darkTrailingTextColor = Color.fromARGB(255, 152, 152, 159);

    final Color lightTileHighlightColor = Color.fromARGB(255, 209, 209, 214);
    final Color darkTileHighlightColor = Color.fromARGB(255, 58, 58, 60);

    final Color lightSettingsTileTextColor = CupertinoColors.black;
    final Color darkSettingsTileTextColor = CupertinoColors.white;

    final CupertinoDynamicColor lightLeadingIconsColor = CupertinoColors.inactiveGray;
    final CupertinoDynamicColor darkLeadingIconsColor = CupertinoColors.inactiveGray;

    final bool isLight = brightness == Brightness.light;

    final Color listBackground =
        isLight ? lightSettingsListBackground : darkSettingsListBackground;

    final Color sectionBackground =
        isLight ? lightSettingSectionColor : darkSettingSectionColor;

    final Color titleTextColor =
        isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

    final Color settingsTileTextColor =
        isLight ? lightSettingsTileTextColor : darkSettingsTileTextColor;

    final Color dividerColor = isLight ? lightDividerColor : darkDividerColor;

    final Color trailingTextColor =
        isLight ? lightTrailingTextColor : darkTrailingTextColor;

    final Color tileHighlightColor =
        isLight ? lightTileHighlightColor : darkTileHighlightColor;

    final CupertinoDynamicColor leadingIconsColor =
        isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

    return SettingsThemeData(
      tileHighlightColor: tileHighlightColor,
      settingsListBackground: listBackground,
      settingsSectionBackground: sectionBackground,
      titleTextColor: titleTextColor,
      dividerColor: dividerColor,
      trailingTextColor: trailingTextColor,
      settingsTileTextColor: settingsTileTextColor,
      leadingIconsColor: leadingIconsColor,
      inactiveTitleColor: CupertinoColors.inactiveGray,
      inactiveSubtitleColor: CupertinoColors.inactiveGray,
    );
  }

  static SettingsThemeData _webTheme({
    required BuildContext context,
    required Brightness brightness,
  }) {
    final Color lightLeadingIconsColor = Color.fromARGB(255, 70, 70, 70);
    final Color darkLeadingIconsColor = Color.fromARGB(255, 197, 197, 197);

    final Color lightSettingsListBackground = Color.fromRGBO(240, 240, 240, 1);
    //done
    final Color darkSettingsListBackground = Color.fromRGBO(32, 33, 36, 1);

    final Color lightSettingSectionColor = CupertinoColors.white;
    //done
    final Color darkSettingSectionColor = Color(0xFF292a2d);

    final Color lightSettingsTitleColor = Color.fromRGBO(11, 87, 208, 1);
    //done
    final Color darkSettingsTitleColor = Color.fromRGBO(232, 234, 237, 1);

    final Color lightTileHighlightColor = Color.fromARGB(255, 220, 220, 220);
    final Color darkTileHighlightColor = Color.fromARGB(255, 46, 46, 46);

    final Color lightSettingsTileTextColor = Color.fromARGB(255, 27, 27, 27);
    //done
    final Color darkSettingsTileTextColor = Color.fromARGB(232, 234, 237, 240);

    final Color lightTileDescriptionTextColor = Color.fromARGB(255, 70, 70, 70);
    final Color darkTileDescriptionTextColor = Color.fromARGB(154, 160, 166, 198);

    final bool isLight = brightness == Brightness.light;

    final Color listBackground =
        isLight ? lightSettingsListBackground : darkSettingsListBackground;

    final Color titleTextColor =
        isLight ? lightSettingsTitleColor : darkSettingsTitleColor;

    final Color settingsTileTextColor =
        isLight ? lightSettingsTileTextColor : darkSettingsTileTextColor;

    final Color tileHighlightColor =
        isLight ? lightTileHighlightColor : darkTileHighlightColor;

    final Color tileDescriptionTextColor =
        isLight ? lightTileDescriptionTextColor : darkTileDescriptionTextColor;

    final Color leadingIconsColor =
        isLight ? lightLeadingIconsColor : darkLeadingIconsColor;

    final Color sectionBackground =
        isLight ? lightSettingSectionColor : darkSettingSectionColor;

    return SettingsThemeData(
      tileHighlightColor: tileHighlightColor,
      settingsListBackground: listBackground,
      titleTextColor: titleTextColor,
      settingsSectionBackground: sectionBackground,
      settingsTileTextColor: settingsTileTextColor,
      tileDescriptionTextColor: tileDescriptionTextColor,
      leadingIconsColor: leadingIconsColor,
    );
  }
}
