// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

import '/src/page_info.dart';
import '/src/page_list.dart';
import '../tree/base.dart';
import '../tree/folder00/_home.dart';
import '../tree/folder00/folder00_03/_home.dart';
import '../tree/folder00/folder00_03/page00_03_01.dart';
import '../tree/folder00/folder00_03/page00_03_02.dart';
import '../tree/folder00/page00_01.dart';
import '../tree/folder00/page00_02.dart';
import '../tree/folder01/_home.dart';
import '../tree/folder01/page01_01.dart';
import '../tree/folder01/page01_02.dart';
import '../tree/folder02/_home.dart';
import '../tree/folder02/page02_01.dart';
import '../tree/folder02/page02_02.dart';
import '../tree/folder03/_home.dart';
import '../tree/folder03/page03_01.dart';

PageGroup gPageGroup = PageGroup();

class TreeNode {
  TreeNode({
    required this.id,
    required this.title,
    Iterable<TreeNode>? children,
  }) : children = <TreeNode>[...?children];

  final String id;
  final String title;
  final List<TreeNode> children;
}

class MyTreeView extends StatefulWidget {
  const MyTreeView({super.key});

  @override
  State<MyTreeView> createState() => MyTreeViewState();
}

class MyTreeViewState extends State<MyTreeView> {
  /// Controller
  late final TreeController<TreeNode> treeController;

  @override
  void initState() {
    /// Pages
    // コントローラの初期化
    treeController = TreeController<TreeNode>(
      roots: gPageGroup.root.children,
      childrenProvider: (TreeNode node) => node.children,
    );
    super.initState();
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TreeView<TreeNode>(
      treeController: treeController,
      nodeBuilder: (BuildContext context, TreeEntry<TreeNode> entry) {
        // Provide a widget to display your tree nodes in the tree view.
        //
        // Can be any widget, just make sure to include a [TreeIndentation]
        // within its widget subtree to properly indent your tree nodes.
        return TreeIndentation(
          entry: entry,
          child: MyTreeTile(
            // Add a key to your tiles to avoid syncing descendant animations.
            key: ValueKey(entry.node),
            treeController: treeController,
            // Your tree nodes are wrapped in TreeEntry instances when traversing
            // the tree, these objects hold important details about its node
            // relative to the tree, like: expansion state, level, parent, etc.
            //
            // TreeEntrys are short lived, each time TreeController.rebuild is
            // called, a new TreeEntry is created for each node so its properties
            // are always up to date.
            entry: entry,
            // Add a callback to toggle the expansion state of this node.
            onTap: () => _onTap2(entry.node),
            // onTap: () => treeController.toggleExpansion(entry.node),
          ),
        );
      },
    );
  }

  void _onTap2(TreeNode node) {
    debugPrint('onTap2');
    Navigator.of(context).pushNamed(_getPath(node));
  }

  String _getPath(TreeNode node) {
    return '/subpage${node.id}';
  }
}

// Create a widget to display the data held by your tree nodes.
class MyTreeTile extends StatelessWidget {
  const MyTreeTile({
    super.key,
    required this.treeController,
    required this.entry,
    required this.onTap,
  });

  final TreeController<TreeNode> treeController;
  final TreeEntry<TreeNode> entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      // Wrap your content in a TreeIndentation widget which will properly
      // indent your nodes (and paint guides, if required).
      //
      // If you don't want to display indent guides, you could replace this
      // TreeIndentation with a Padding widget, providing a padding of
      // `EdgeInsetsDirectional.only(start: TreeEntry.level * indentAmount)`
      child: Padding(
        padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
        child: Row(
          children: [
            // Add a widget to indicate the expansion state of this node.
            // See also: ExpandIcon.
            FolderButton(
              isOpen: entry.hasChildren ? entry.isExpanded : null,
              // onPressed: entry.hasChildren ? onTap : null,
              onPressed: entry.hasChildren ? toggle : null,
            ),
            Text(entry.node.title),
          ],
        ),
      ),
    );
  }

  void toggle() {
    treeController.toggleExpansion(entry.node);
  }
}

/// Page controller
class PageGroup {
  final List<PageInfo> _pages = <PageInfo>[];

  /// Contents
  late final TreeNode root = TreeNode(id: '/', title: '🌲️ ROOT');
  // final List<TreeNode> _treeNode = <TreeNode>[];

  /// Page collections
  PageGroup() {
    int section = 0;
    _pages.add(PageInfo(ss(section), const Base()));
    _pageFolder0(ss(++section));
    _pageFolder1(ss(++section));
    _pageFolder2(ss(++section));
    _pageFolder3(ss(++section));
    generateTree();
  }

  /// Int to String
  String ss(int i) {
    return i.toString();
  }

  void _pageFolder0(String S) {
    int sub1 = 0;
    int sub2 = 0;
    _pages.add(Folder00(S));
    _pages.add(PageInfo('$S.${++sub1}', const Page00_01()));
    _pages.add(PageInfo('$S.${++sub1}', const Page00_02()));

    _pages.add(Folder00_03('$S.${++sub1}'));
    _pages.add(PageInfo('$S.$sub1.${sub2 = 1}', const Page00_03_01()));
    _pages.add(PageInfo('$S.$sub1.${++sub2}', const Page00_03_02()));
  }

  void _pageFolder1(String S) {
    int sub1 = 0;
    _pages.add(Folder01(S));
    _pages.add(PageInfo('$S.${++sub1}', const Page01_01()));
    _pages.add(PageInfo('$S.${++sub1}', const Page01_02()));
  }

  void _pageFolder2(String S) {
    int sub1 = 0;
    _pages.add(Folder02(S));
    _pages.add(PageInfo('$S.${++sub1}', const Page02_01()));
    _pages.add(PageInfo('$S.${++sub1}', const Page02_02()));
  }

  void _pageFolder3(String S) {
    int sub1 = 0;
    _pages.add(Folder03(S));
    _pages.add(PageInfo('$S.${++sub1}', const Page03_01()));
  }

  /// Tester
  void test01() {
    showTree(root.children);
  }

  /// DebugPrint tree nods
  void showTree(List<TreeNode> tree) {
    for (final TreeNode node in tree) {
      showTreeNode(node);
    }
  }

  /// debug print node
  void showTreeNode(TreeNode node) {
    debugPrint(node.toString());
    for (final TreeNode node in node.children) {
      showTreeNode(node);
    }
  }

  /// Generate tree
  void generateTree() {
    for (final PageInfo page in _pages) {
      // Create a tree node
      final TreeNode node = TreeNode(
        id: page.id,
        title: page.title,
      );
      // find the parent node
      final TreeNode? parent = _getParentNode(page.id);
      if (parent != null) {
        parent.children.add(node);
      } else {
        root.children.add(node);
      }
    }
    // debugPrint('Tree generated. LEN:${_treeNode.length}');
  }

  TreeNode? _getParentNode(String childId) {
    final PageInfo? page = getPageInfo(childId);
    if (page == null) {
      return null;
    }
    final String? parentId = getParentId(page.id);
    if (parentId == null) {
      return null;
    }
    for (final TreeNode node in root.children) {
      final TreeNode? found = findNode(node, parentId);
      if (found != null) {
        return found;
      }
    }
    return null;
  }

  /// Find a treeNode with specified Id recursively
  TreeNode? findNode(TreeNode treeNode, String id) {
    if (treeNode.id == id) {
      return treeNode;
    }
    for (final TreeNode tn in treeNode.children) {
      final TreeNode? node = findNode(tn, id);
      if (node != null) {
        return node;
      }
    }
    return null;
  }

  /// Get page routes
  Map<String, WidgetBuilder> routes() {
    final Map<String, WidgetBuilder> routeMap1 = <String, WidgetBuilder>{};
    for (int idx = 0; idx < _pages.length; idx++) {
      final PageInfo page = _pages[idx];
      routeMap1[page.getPath()] = (BuildContext context) => getPage(idx);
    }
    return routeMap1;
  }

  /// Get page list of the page section
  PageList getChildPages({required String? id}) {
    if (id == null) {
      return PageList();
    }
    final String parentSection = id;

    final PageList pList = PageList();
    for (final PageInfo page in _pages) {
      final String? parentId = getParentId(page.id);
      if (parentSection == parentId) {
        pList.add(page);
      }
    }
    return pList;
  }

  /// Get my parent ID
  String? getParentId(String id) {
    final int idx = id.lastIndexOf('.');
    if (idx < 0) {
      return null;
    }
    return id.substring(0, idx);
  }

  /// Get page title
  String getTitle(String id) {
    final PageInfo? page = getPageInfo(id);
    if (page == null) {
      return '';
    }
    return page.title;
  }

  /// Get page widget
  Widget getPage(int idx) {
    return _pages[idx].page;
  }

  /// Get page by id
  PageInfo? getPageInfo(String id) {
    for (final PageInfo page in _pages) {
      if (page.id == id) {
        return page;
      }
    }
    return null;
  }

  /// get total pages
  int getSize() {
    return _pages.length;
  }
}
