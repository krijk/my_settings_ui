import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/globals.dart';

const String applicationTitle = 'example1';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: initPref(context),
      builder: (BuildContext context, AsyncSnapshot<bool> snap) {
        if (snap.hasData) {
          return buildContents(context);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<bool> initPref(BuildContext context) async {
    await ref.read(settingProvider).retrievePreference();
    return true;
  }

  Widget buildContents(BuildContext context) {
    return MaterialApp(
      title: applicationTitle,
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: ref.watch(settingProvider).state.textDirection,
          child: child!,
        );
      },
      home: const AppView(),
    );
  }
}

class AppView extends ConsumerWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body:
      Text('AppView'),
    );

  }
}
