import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//* Theme Color ----------------------------------------------------------------

class ColorSelector extends ConsumerWidget {
  const ColorSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color selectedColor = ref.watch(settingProvider).state.color;

    return ExpansionTile(
      title: const Text('Accent Color'),
      trailing: ColorOption(color: selectedColor, canTap: false),
      shape: const RoundedRectangleBorder(/*side: BorderSide.none*/),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: <Widget>[
        GridView.extent(
          shrinkWrap: true,
          maxCrossAxisExtent: 24,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Color>[Colors.grey, Colors.black, Colors.white]
              .followedBy(Colors.primaries.reversed)
              .followedBy(Colors.accents)
              .map(ColorOption.fromColor)
              .toList(growable: false),
        ),
      ],
    );
  }
}

class ColorOption extends ConsumerWidget {
  const ColorOption({
    super.key,
    required this.color,
    this.canTap = true,
  });

  factory ColorOption.fromColor(Color color) => ColorOption(color: color);

  final Color color;
  final bool canTap;

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void updateColor() => ref.read(settingProvider).updateColor(color);
    return Material(
      color: color,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: canTap ? updateColor : null,
        child: const SizedBox.square(dimension: 24),
      ),
    );
  }
}
