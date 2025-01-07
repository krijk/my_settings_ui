class TreeNode1 {
  TreeNode1({
    required this.id,
    required this.title,
    Iterable<TreeNode1>? children,
  }) : children = <TreeNode1>[...?children];

  final String id;
  final String title;
  final List<TreeNode1> children;
}
