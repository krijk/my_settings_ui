import 'package:flutter/material.dart';

class AppIntroduction extends StatelessWidget {
  const AppIntroduction({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Introduction'),
      subtitle: const Text('App intro'),
      leading: const Icon(Icons.announcement),
      onTap: () {},
    );
  }
}
