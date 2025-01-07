// ignore_for_file: avoid_setters_without_getters
import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';

/// My stateful state base
class MyWidgetStateBase04<T> extends State {
  /// state progress message
  String text = '';
  String _labelBtn1 = 'Test1';
  String _labelBtn2 = 'Test2';

  Widget _portraitMode(BuildContext context) {
    final double width = UI.screenWidth(context);
    final double height = UI.screenHeight(context);
    const double paramWidth = 0.9;
    const double paramHeight = 0.75;
    return Scrollbar(
      child: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: UI.textArea(text, width * paramWidth, height * paramHeight),
            ),
            controlsHorizontal(context),
          ],
        ),
      ),
    );
  }

  Widget _landscapeMode(BuildContext context) {
    final double height = UI.screenHeight(context);
    const double paramWidth = 0.9;
    const double paramHeight = 0.6;
    return Row(
      children: <Widget>[
        Expanded(
          child: UI.textArea(text, height * paramWidth, height * paramHeight),
        ),
        controlsVertical(context),
      ],
    );
  }

  /// append message
  void append(String tx) {
    if(mounted){
      setState(() {
        text += '$tx\n';
      });
    }
  }

  /// append int value
  void appendInt(int val) {
    if(mounted){
      setState(() {
        text += '$val\n';
      });
    }
  }

  /// add a log line
  void addLog(dynamic msg) {
    const int idxStart = 11;
    const int len = 12;
    final String line = '${DateTime.now().toString().substring(idxStart, idxStart + len)}${', $msg'}';
    append(line);
  }

  /// line feed
  void newline() {
    append('\n');
  }

  /// Clear log
  void clearLog() {
    text = '';
  }

  /// Set button label
  set btn1Label(String label) {
    _labelBtn1 = label;
  }

  /// Set button label
  set btn2Label(String label) {
    _labelBtn2 = label;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return _portraitMode(context);
        } else {
          return _landscapeMode(context);
        }
      },
    );
  }

  /// Test function
  void onTest01() {}

  /// Test function
  void onTest02() {}

  /// Control area
  Widget controlsHorizontal(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back'),
        ),
        ElevatedButton(
          onPressed: () => onTest01(),
          child: Text(_labelBtn1),
        ),
        ElevatedButton(
          onPressed: () => onTest02(),
          child: Text(_labelBtn2),
        ),
      ],
    );
  }

  /// Control area
  Widget controlsVertical(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back'),
        ),
        ElevatedButton(
          onPressed: () => onTest01(),
          child: Text(_labelBtn1),
        ),
        ElevatedButton(
          onPressed: () => onTest02(),
          child: Text(_labelBtn2),
        ),
      ],
    );
  }
}
