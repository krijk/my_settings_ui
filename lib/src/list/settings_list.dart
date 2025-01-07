import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/src/sections/abstract_settings_section.dart';
import '/src/utils/platform_utils.dart';
import '/src/utils/settings_theme.dart';
import '/src/utils/theme_provider.dart';

enum ApplicationType {
  /// Use this parameter is you are using the MaterialApp
  material,

  /// Use this parameter is you are using the CupertinoApp
  cupertino,

  /// Use this parameter is you are using the MaterialApp for Android
  /// and the CupertinoApp for iOS.
  both,
}

class SettingsList extends StatelessWidget {
  const SettingsList({
    required this.sections,
    this.shrinkWrap = false,
    this.physics,
    this.platform,
    this.lightTheme,
    this.darkTheme,
    this.brightness,
    this.contentPadding,
    this.applicationType = ApplicationType.material,
    super.key,
  });

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final DevicePlatform? platform;
  final SettingsThemeData? lightTheme;
  final SettingsThemeData? darkTheme;
  final Brightness? brightness;
  final EdgeInsetsGeometry? contentPadding;
  final List<AbstractSettingsSection> sections;
  final ApplicationType applicationType;

  @override
  Widget build(BuildContext context) {
    DevicePlatform platform;
    if (this.platform == null || this.platform == DevicePlatform.device) {
      platform = PlatformUtils.detectPlatform(context);
    } else {
      platform = this.platform!;
    }

    final Brightness brightness = calculateBrightness(context);

    final SettingsThemeData themeData = ThemeProvider.getTheme(
      context: context,
      platform: platform,
      brightness: brightness,
    ).merge(theme: brightness == Brightness.dark ? darkTheme : lightTheme);

    return Container(
      color: themeData.settingsListBackground,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 810),
        child: SettingsTheme(
          themeData: themeData,
          platform: platform,
          child: ListView.builder(
            physics: physics,
            shrinkWrap: shrinkWrap,
            itemCount: sections.length,
            padding: contentPadding ?? calculateDefaultPadding(platform),
            itemBuilder: (BuildContext context, int index) {
              return sections[index];
            },
          ),
        ),
      ),
    );
  }

  EdgeInsets calculateDefaultPadding(DevicePlatform platform) {
    switch (platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
        return EdgeInsets.only(top: 0);
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return EdgeInsets.symmetric(vertical: 20);
      case DevicePlatform.web:
        return EdgeInsets.zero;
      case DevicePlatform.device:
        throw Exception(
          "You can't use the DevicePlatform.device in this context. "
          'Incorrect platform: SettingsList.calculateDefaultPadding',
        );
    }
  }

  Brightness calculateBrightness(BuildContext context) {
    final Brightness materialBrightness = Theme.of(context).brightness;
    final Brightness cupertinoBrightness = CupertinoTheme.of(context).brightness ??
        MediaQuery.of(context).platformBrightness;

    switch (applicationType) {
      case ApplicationType.material:
        return materialBrightness;
      case ApplicationType.cupertino:
        return cupertinoBrightness;
      case ApplicationType.both:
        return kIsWeb || !Platform.isIOS
            ? materialBrightness
            : cupertinoBrightness;
    }
  }
}
