import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

class Node {
  Node({
    required this.title,
    Iterable<Node>? children,
  }) : children = <Node>[...?children];

  final String title;
  final List<Node> children;
}

/// tree view
class MinimalTreeView1 extends StatefulWidget {
  const MinimalTreeView1({super.key});

  @override
  State<MinimalTreeView1> createState() => _MinimalTreeView1State();
}

class _MinimalTreeView1State extends State<MinimalTreeView1> {
  /// Controller
  late final TreeController<Node> treeController;
  /// Contents
  late final Node root = Node(title: '/');

  @override
  void initState() {
    super.initState();

    populateTree(root);

    treeController = TreeController<Node>(
      roots: root.children,
      childrenProvider: (Node node) => node.children,
    );
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TreeView<Node>(
      treeController: treeController,
      nodeBuilder: (BuildContext context, TreeEntry<Node> entry) {
        return TreeIndentation(
          entry: entry,
          child: Row(
            children: <Widget>[
              ExpandIcon(
                key: GlobalObjectKey(entry.node),
                isExpanded: entry.isExpanded,
                onPressed: (_) => treeController.toggleExpansion(entry.node),
              ),
              Flexible(
                child: Text(entry.node.title),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ID
int _uniqueId = 0;

void populateTree(Node node, [int level = 0]) {

  if (level >= 7) return;

  // Child
  node.children.addAll(<Node>[
    Node(title: 'Node ${_uniqueId++}'),
    Node(title: 'Node ${_uniqueId++}'),
  ]);
  // nest call
  for (final Node child in node.children) {
    populateTree(child, level + 1);
  }
}
