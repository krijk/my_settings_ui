import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart' as mylib;

import '/src/page_stateless.dart';

enum _kTool {
  test01,
  ;

  static _kTool? getEnum(int index) {
    for (final _kTool e in _kTool.values) {
      if (e.index == index) {
        return e;
      }
    }
    return null;
  }
}

typedef FuncOnPressed = void Function(int);
String buttonLabel = 'button';

/// Page
class PageTools extends PageStateless {
  ///
  const PageTools() : super('Tools');

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
      body: const MyPageParent(),
    );
  }
}

/// Page parent
class MyPageParent extends StatefulWidget {
  const MyPageParent();

  @override
  MyPageState createState() => MyPageState();
}

/// Page state
class MyPageState extends State<MyPageParent> {
  String textAction = 'Click it..';

  late Params params;

  @override
  void initState() {
    params = Params(callback: onPressed);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    params.build(context);
    return Scaffold(
      body: _controls(),
    );
  }

  Widget _controls() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(params.paddingText),
          child: Text(textAction),
        ),
        Flexible(
          child: Scrollbar(
            thickness: params.scrollBarThickness,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: params.paddingFrame),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: params.list.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: params.buttonSize,
                        crossAxisCount: params.countColumn,
                        crossAxisSpacing: params.buttonSpaceColumn,
                        mainAxisSpacing: params.buttonSpaceRow,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return params.list[index];
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onPressed(int index) {
    final _kTool tool = _kTool.getEnum(index)!;
    switch (tool) {
      case _kTool.test01:
        test01();
        break;
    }
    setState(() {
      textAction = tool.name;
    });
  }

  void test01() {
  }
}

class Params {
  FuncOnPressed? callback;

  // final int _numButtons = 100;
  List<Widget> list = <Widget>[];

  int countColumn = 3;
  double buttonSize = 2.0; // Smaller the bigger button size
  double buttonSpaceColumn = 4.0;
  double buttonSpaceRow = 6.0;
  double buttonFontSize = 10.0;
  double paddingFrame = 10;
  double scrollBarThickness = 3;
  double paddingText = 20;

  Params({this.callback});

  void _init() {
    list = <Widget>[];
    for (final _kTool e in _kTool.values) {
      list.add(_controlItem(e.index, buttonFontSize));
    }
  }

  void build(BuildContext context) {
    final bool isLinux = mylib.Utl.isPlatform(mylib.kPlatform.linux);
    final Orientation orientation = MediaQuery.of(context).orientation;
    if (isLinux) {
      countColumn = 6;
      if (orientation == Orientation.landscape) {
        countColumn = 8;
      }
      buttonSize = 1.0;
      buttonSpaceColumn = 20.0;
      buttonSpaceRow = 10.0;
      buttonFontSize = 12.0;
      paddingFrame = 60;
      scrollBarThickness = 3;
      paddingText = 20;
    } else {
      countColumn = 3;
      if (orientation == Orientation.landscape) {
        countColumn = 5;
      }
      buttonSize = 2.0;
      buttonSpaceColumn = 4.0;
      buttonSpaceRow = 6.0;
      buttonFontSize = 12.0;
      paddingFrame = 10;
      scrollBarThickness = 3;
      paddingText = 20;
    }
    _init();
  }

  Widget _controlItem(int index, double buttonFontSize) {
    final _kTool tool = _kTool.getEnum(index)!;

    return ElevatedButton(
      onPressed: () => callback?.call(index),
      child: Text(
        tool.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: buttonFontSize,
        ),
      ),
    );
  }
}
