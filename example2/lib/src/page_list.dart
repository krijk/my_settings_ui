import 'package:flutter/material.dart';
import 'page_base.dart';
import 'page_info.dart';

/// Page group
class PageList {
  ///
  final List<PageInfo> _pages = <PageInfo>[];

  /// add a page information
  void add(PageInfo page) {
    _pages.add(page);
  }

  /// Page routes
  Map<String, WidgetBuilder> routes() {
    final Map<String, WidgetBuilder> routeMap1 = <String, WidgetBuilder>{};
    for (int idx = 0; idx < _pages.length; idx++) {
      final PageInfo page = _pages[idx];
      routeMap1[page.getPath()] = (BuildContext context) => getPage(idx);
    }
    return routeMap1;
  }

  /// Get card_list information
  PageBase getPage(int idx) {
    return _pages[idx].page;
  }

  /// Get the number of total card_list
  int getSize() {
    return _pages.length;
  }
}
