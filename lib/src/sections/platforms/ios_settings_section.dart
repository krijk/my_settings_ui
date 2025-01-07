import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/src/tiles/abstract_settings_tile.dart';
import '/src/tiles/platforms/ios_settings_tile.dart';
import '/src/tiles/settings_tile.dart';
import '/src/utils/settings_theme.dart';

class IOSSettingsSection extends StatelessWidget {
  const IOSSettingsSection({
    required this.tiles,
    required this.margin,
    required this.title,
    super.key,
  });

  final List<AbstractSettingsTile> tiles;
  final EdgeInsetsDirectional? margin;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    final SettingsTheme theme = SettingsTheme.of(context);
    final bool isLastNonDescriptive = tiles.last is SettingsTile &&
        (tiles.last as SettingsTile).description == null;
    final double scaleFactor = MediaQuery.textScalerOf(context).scale(1);

    return Padding(
      padding: margin ??
          EdgeInsets.only(
            top: 14.0 * scaleFactor,
            bottom: isLastNonDescriptive ? 27 * scaleFactor : 10 * scaleFactor,
            left: 16,
            right: 16,
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: EdgeInsetsDirectional.only(
                start: 18,
                bottom: 5 * scaleFactor,
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  color: theme.themeData.titleTextColor,
                  fontSize: 13,
                ),
                child: title!,
              ),
            ),
          buildTileList(),
        ],
      ),
    );
  }

  Widget buildTileList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tiles.length,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        final AbstractSettingsTile tile = tiles[index];

        bool enableTop = false;

        if (index == 0 ||
            (index > 0 &&
                tiles[index - 1]  is SettingsTile &&
                (tiles[index - 1] as SettingsTile).description != null)) {
          enableTop = true;
        }

        bool enableBottom = false;

        if (index == tiles.length - 1 ||
            (index < tiles.length &&
                tile is SettingsTile &&
                tile.description != null)) {
          enableBottom = true;
        }

        return IOSSettingsTileAdditionalInfo(
          enableTopBorderRadius: enableTop,
          enableBottomBorderRadius: enableBottom,
          needToShowDivider: index != tiles.length - 1,
          child: tile,
        );
      },
    );
  }
}
