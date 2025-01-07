import 'package:example2/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../contents/tree_node1.dart';

GlobalKey<SearchFilterState> keySearch = GlobalKey();

class SearchNotifier extends ValueNotifier<bool> {
  SearchNotifier() : super(false);

  void onPressed() {
    value = !value;
    if(value == false){
      keySearch.currentState?.clearSearch();
    }
  }
}

class SearchFilterWidget extends ConsumerStatefulWidget {
  final TreeController<TreeNode1> treeController;
  const SearchFilterWidget({super.key, required this.treeController});

  @override
  SearchFilterState createState() => SearchFilterState();
}

class SearchFilterState extends ConsumerState<SearchFilterWidget> {
  late final TextEditingController searchBarTextEditingController;
  TreeSearchResult<TreeNode1>? filter;
  Pattern? searchPattern;
  bool isCaseSensitive = false;

  @override
  void initState() {
    searchBarTextEditingController = TextEditingController();
    searchBarTextEditingController.addListener(onSearchQueryChanged);
    super.initState();
  }

  @override
  void dispose() {
    filter = null;
    searchPattern = null;
    searchBarTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearch = ref.watch(searchProvider).value;
    isCaseSensitive = ref.watch(settingProvider).state.filterCapital;

    return isSearch
        ? Padding(
            padding: const EdgeInsets.all(8),
            child: SearchBar(
              controller: searchBarTextEditingController,
              hintText: 'Type to Filter',
              leading: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.filter_list),
              ),
              trailing: <Widget>[
                Badge(
                  isLabelVisible: filter != null,
                  label: Text(
                    '${filter?.totalMatchCount}/${filter?.totalNodeCount}',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: clearSearch,
                ),
              ],
            ),
          )
        : Container();
  }

  void onSearchQueryChanged() {
    final String query = searchBarTextEditingController.text.trim();

    if (query.isEmpty) {
      clearSearch();
      return;
    }

    search(query);
  }

  void clearSearch() {
    if (filter == null) return;

    setState(() {
      filter = null;
      searchPattern = null;
      widget.treeController.rebuild();
      searchBarTextEditingController.clear();
    });
  }

  void search(String query) {
    // Needs to be reset before searching again, otherwise the tree controller
    // wouldn't reach some nodes because of the `getChildren()` impl above.
    filter = null;

    Pattern pattern;
    try {
      pattern = RegExp(query, caseSensitive: isCaseSensitive);
    } on FormatException {
      pattern = query;
    }
    searchPattern = pattern;

    filter = widget.treeController.search((TreeNode1 node) => node.title.contains(pattern));
    widget.treeController.rebuild();

    if (mounted) {
      setState(() {});
    }
  }
}
