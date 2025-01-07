/// https://dart.dev/samples#interfaces-and-abstract-classes
library;
import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';
import 'page_base.dart';

/// Stateless page
abstract class PageStateless extends PageBase {
  /// Stateless page
  const PageStateless(super.title, {super.key});

  Widget _portraitMode(BuildContext context) {
    final double height = UI.screenHeight(context);
    const double paramWidth = 0.9;
    const double paramHeight = 0.75;
    return Scrollbar(
      child: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              child: UI.textArea(test(), height * paramWidth, height * paramHeight),
            ),
            controlsHorizontal(context),
          ],
        ),
      ),
    );
  }

  Widget _landscapeMode(BuildContext context) {
    final double width = UI.screenWidth(context);
    final double height = UI.screenHeight(context);
    const double paramWidth = 0.9;
    const double paramHeight = 0.6;
    return Column(
      children: <Widget>[
        Expanded(
          child: UI.textArea(test(), width * paramWidth, height * paramHeight),
        ),
        controlsVertical(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return _portraitMode(context);
          } else {
            return _landscapeMode(context);
          }
        },
      ),
    );
  }

  /// Control area
  Widget controlsHorizontal(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Back'),
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
      ],
    );
  }
}
