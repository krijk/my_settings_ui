import 'package:flutter/material.dart';

/// Base class for page
abstract class PageBase extends StatelessWidget {

  /// page title
  final String title;

  /// Base class for page
  const PageBase(this.title, {super.key});

  /// test function
  String test() {
    return '';
  }
}
