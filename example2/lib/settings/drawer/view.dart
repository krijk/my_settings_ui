import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'categories.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, this.isDrawer = false});

  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    late final Widget child = Column(
      children: <Widget>[
        Header(showCloseButton: isDrawer),
        const Divider(height: 1),
        const Expanded(child: SettingsCategories()),
      ],
    );

    if (isDrawer) {
      return Drawer(child: child);
    }

    return Material(
      child: SizedBox(
        width: 304,
        child: ListTileTheme.merge(
          style: ListTileStyle.drawer,
          child: child,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, this.showCloseButton = false});

  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const DarkModeButton(),
            if (showCloseButton)
              IconButton(
                tooltip: 'Close settings',
                icon: const Icon(Icons.close),
                onPressed: () => Scaffold.maybeOf(context)?.closeDrawer(),
              ),
          ],
        ),
      ),
    );
  }
}


//* Dark Mode ------------------------------------------------------------------

class DarkModeButton extends ConsumerWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Brightness brightness = ref.watch(settingProvider).state.brightness;

    final Brightness oppositeBrightness;
    final Widget icon;
    final String tooltip;

    if (brightness == Brightness.light) {
      oppositeBrightness = Brightness.dark;
      icon = const Icon(Icons.dark_mode_outlined);
      tooltip = 'Dark Mode';
    } else {
      oppositeBrightness = Brightness.light;
      icon = const Icon(Icons.light_mode_outlined);
      tooltip = 'Light Mode';
    }

    return IconButton(
      icon: icon,
      tooltip: tooltip,
      onPressed: () => ref.read(settingProvider).updateBrightness(oppositeBrightness),
    );
  }
}
