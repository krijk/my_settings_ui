import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/contents/pages.dart';
import '/globals.dart';
import '/settings/drawer/view.dart';
import '/src/searcher.dart';
import '../contents/selection.dart';

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

  Widget buildContents(BuildContext context) {
    return MaterialApp(
      title: applicationTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: ref.watch(settingProvider).state.color,
        brightness: ref.watch(settingProvider).state.brightness,
      ),
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: ref.watch(settingProvider).state.textDirection,
          child: child!,
        );
      },
      home: const AppView(),
      routes: gPageGroup.routes(),
    );
  }

  Future<bool> initPref(BuildContext context) async {
    await ref.read(settingProvider).retrievePreference();
    return true;
  }
}

class AppView extends ConsumerWidget {
  const AppView({super.key});

  /// Necessary when resizing the app so the tree view example inside the
  /// main view doesn't loose its tree states.
  static const GlobalObjectKey<State<StatefulWidget>> examplesViewKey = GlobalObjectKey('<ExamplesViewKey>');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SearchNotifier searchNotifier = ref.read(searchProvider);

    PreferredSizeWidget? appBar;
    Widget? body;
    Widget? drawer;

    if (MediaQuery.of(context).size.width > gScreenLarge) {
      // Desktop
      body = const Row(
        children: <Widget>[
          SettingsView(),
          VerticalDivider(width: 1),
          Expanded(child: ContentView(key: examplesViewKey)),
        ],
      );
    } else {
      // Mobile
      appBar = AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: searchNotifier.value ? Theme.of(context).colorScheme.primaryContainer : null,
            ),
            onPressed: () {
              searchNotifier.onPressed();
            },
          ),
        ],
        title: const Text(appBarTitle),
        notificationPredicate: (_) => false,
        titleSpacing: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      );
      body = const ContentView(key: examplesViewKey);
      drawer = const Padding(
        padding: EdgeInsets.only(top: 20),
        child: SettingsView(isDrawer: true),
      );
    }

    return Scaffold(
      appBar: appBar,
      body: body,
      drawer: drawer,
    );
  }
}
