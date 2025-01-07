import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

import 'tree_node1.dart';

class MyTreeTile4 extends StatefulWidget {
  const MyTreeTile4({
    super.key,
    required this.treeController,
    required this.entry,
    required this.onTap,
    required this.match,
    required this.searchPattern,
  });

  final TreeController<TreeNode1> treeController;
  final TreeEntry<TreeNode1> entry;
  final VoidCallback onTap;

  final TreeSearchMatch? match;
  final Pattern? searchPattern;

  @override
  State<MyTreeTile4> createState() => _MyTreeTile4State();
}

class _MyTreeTile4State extends State<MyTreeTile4> {
  late InlineSpan titleSpan;

  TextStyle? dimStyle;
  TextStyle? highlightStyle;

  bool get shouldShowBadge => !widget.entry.isExpanded && (widget.match?.subtreeMatchCount ?? 0) > 0;

  @override
  Widget build(BuildContext context) {
    final TreeEntry<TreeNode1> entry = widget.entry;
    return InkWell(
      onTap: onTap,
      // Wrap your content in a TreeIndentation widget which will properly
      // indent your nodes (and paint guides, if required).
      //
      // If you don't want to display indent guides, you could replace this
      // TreeIndentation with a Padding widget, providing a padding of
      // `EdgeInsetsDirectional.only(start: TreeEntry.level * indentAmount)`
      child: TreeIndentation(
        entry: widget.entry,
        // Provide an indent guide if desired. Indent guides can be used to
        // add decorations to the indentation of tree nodes.
        // This could also be provided through a DefaultTreeIndentGuide
        // inherited widget placed above the tree view.
        guide: const IndentGuide.connectingLines(indent: 48),
        // The widget to render next to the indentation. TreeIndentation
        // respects the text direction of `Directionality.maybeOf(context)`
        // and defaults to left-to-right.
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
          child: Row(
            children: <Widget>[
              // Add a widget to indicate the expansion state of this node.
              // See also: ExpandIcon.
              FolderButton(
                isOpen: entry.hasChildren ? entry.isExpanded : null,
                // onPressed: entry.hasChildren ? onTap : null,
                onPressed: entry.hasChildren ? toggle : null,
              ),
              if (shouldShowBadge)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: Badge(
                    label: Text('${widget.match?.subtreeMatchCount}'),
                  ),
                ),
              Flexible(child: Text.rich(titleSpan)),
            ],
          ),
        ),
      ),
    );
  }

  void onTap() {
    widget.onTap();
  }

  void toggle() {
    TreeViewScope.of<TreeNode1>(context).controller.toggleExpansion(widget.entry.node);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setupTextStyles();
    titleSpan = buildTextSpan();
  }

  @override
  void didUpdateWidget(covariant MyTreeTile4 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchPattern != widget.searchPattern || oldWidget.entry.node.title != widget.entry.node.title) {
      titleSpan = buildTextSpan();
    }
  }

  void setupTextStyles() {
    final TextStyle style = DefaultTextStyle.of(context).style;
    final Color highlightColor = Theme.of(context).colorScheme.primary;
    highlightStyle = style.copyWith(
      color: highlightColor,
      decorationColor: highlightColor,
      decoration: TextDecoration.underline,
    );
    dimStyle = style.copyWith(color: style.color?.withAlpha(128));
  }

  InlineSpan buildTextSpan() {
    final String title = widget.entry.node.title;

    if (widget.searchPattern == null) {
      return TextSpan(text: title);
    }

    final List<InlineSpan> spans = <InlineSpan>[];
    bool hasAnyMatches = false;

    title.splitMapJoin(
      widget.searchPattern!,
      onMatch: (Match match) {
        hasAnyMatches = true;
        spans.add(TextSpan(text: match.group(0), style: highlightStyle));
        return '';
      },
      onNonMatch: (String text) {
        spans.add(TextSpan(text: text));
        return '';
      },
    );

    if (hasAnyMatches) {
      return TextSpan(children: spans);
    }

    return TextSpan(text: title, style: dimStyle);
  }
}
