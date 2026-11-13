import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart' show App;

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

