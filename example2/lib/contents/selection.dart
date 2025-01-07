import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/settings/controller.dart';
import 'drag_and_drop.dart';
import 'filterable2.dart';
import 'minimal1.dart';
import 'pages.dart';

const Selection initialSelection = Selection.navi2;

class SelectedNotifier extends ValueNotifier<Selection> {
  SelectedNotifier() : super(initialSelection);

  void select(Selection? selection) {
    if (selection == null) return;
    value = selection;
  }
}

/// FIXME:
enum Selection {
  navi2('navi2', Icon(Icons.navigation), filterAble: true),
  filterable('filterable', Icon(Icons.filter_alt), filterAble: true),
  dragAndDrop('Drag and Drop', Icon(Icons.move_down_rounded)),
  minimal1('Minimal1', Icon(Icons.segment)),
  ;

  const Selection(this.title, this.icon, {this.filterAble = false});

  final String title;
  final Widget icon;
  final bool filterAble;

  /// The Tree
  Widget get tree {
    return switch (this) {
      Selection.navi2 => const MyTreeView(),
      Selection.dragAndDrop => const DragAndDropTreeView(),
      Selection.minimal1 => const MinimalTreeView1(),
      Selection.filterable => const FilterableTreeView2(),
    };
  }
}

/// Contents
class ContentView extends ConsumerWidget {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// contents
    final Selection selected = ref.watch(selectedProvider).value;

    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child: TreeIndentGuideScope(
        key: Key(selected.title),

        /// The Tree
        child: selected.tree,
      ),
    );
  }
}

class TreeIndentGuideScope extends ConsumerWidget {
  const TreeIndentGuideScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SettingsState state = ref.watch(settingProvider).state;

    final IndentGuide guide;

    switch (state.indentType) {
      case IndentType.connectingLines:
        guide = IndentGuide.connectingLines(
          indent: state.indent,
          color: Theme.of(context).colorScheme.outline,
          thickness: state.lineThickness,
          origin: state.lineOrigin,
          roundCorners: state.roundedCorners,
        );
        break;
      case IndentType.scopingLines:
        guide = IndentGuide.scopingLines(
          indent: state.indent,
          color: Theme.of(context).colorScheme.outline,
          thickness: state.lineThickness,
          origin: state.lineOrigin,
        );
        break;
      case IndentType.blank:
        guide = IndentGuide(indent: state.indent);
        break;
    }

    return DefaultIndentGuide(
      guide: guide,
      child: child,
    );
  }
}
