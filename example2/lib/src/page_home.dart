import 'package:flutter/material.dart';

import '/contents/pages.dart';
import '/src/card_view.dart';
import '/src/page_list.dart';
import 'page_base.dart';
import 'page_info.dart';

/// Folder home with CardList
class PageHome extends PageInfo {
  ///
  final String description;

  ///
  PageHome(String id, String title, {this.description = ''}) : super(id, HomeContent(id, title, description));
}

/// Page
class HomeContent extends PageBase {
  ///
  final String id;

  ///
  final String description;

  ///
  const HomeContent(this.id, String title, this.description, {super.key}) : super(title);

  @override
  Widget build(BuildContext context) {
    final PageList pageList = gPageGroup.getChildPages(id: id);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
              child: Text(description),
            ),
            Expanded(
              child: CardWidget(pageList),
            ),
          ],
        ),
      ),
    );
  }

  @override
  String test() {
    throw UnimplementedError();
  }
}
