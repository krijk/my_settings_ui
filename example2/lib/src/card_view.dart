import 'package:flutter/material.dart';

import 'page_base.dart';
import 'page_list.dart';

/// Card widget
class CardWidget extends StatefulWidget {
  /// Card widget for list
  const CardWidget(this.list, {super.key});

  /// page contents
  final PageList list;

  @override
  State<CardWidget> createState() => CardState();

  /// Get card_list routes
  Map<String, WidgetBuilder> routes() {
    return list.routes();
  }
}

/// Card State
class CardState extends State<CardWidget> {
  /// Get related card_list group
  PageList getGroup() {
    return widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          final PageBase page = getGroup().getPage(index);
          return Card(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return page;
                    },
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  page.title,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          );
        },
        itemCount: getGroup().getSize(),
      ),
    );
  }
}
