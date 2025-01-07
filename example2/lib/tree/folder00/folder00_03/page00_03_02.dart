import 'package:flutter/material.dart';

import '/src/my_state04.dart';
import '/src/page_stateless.dart';

/// Page
class Page00_03_02 extends PageStateless {
  ///
  const Page00_03_02() : super('Page00_03_02');

  @override
  String test() {
    return '${_test01()}'
        '\n\n${_test02()}';
  }

  String _test01() {
    return 'test01';
  }

  String _test02() {
    return 'test02';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: MyPageParent(),
    );
  }
}

/// Page parent
class MyPageParent extends StatefulWidget {
  @override
  MyPageState createState() => MyPageState();
}

/// Page state
class MyPageState extends MyWidgetStateBase04<MyPageParent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> onTest01() async {}

  @override
  Future<void> onTest02() async {}
}
