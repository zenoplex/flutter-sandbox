import 'package:flutter/material.dart';
// import 'package:flutter_sandbox/flex_screen.dart';
// import 'package:flutter_sandbox/profile_screen.dart';
import 'package:flutter_sandbox/deep_tree.dart';

void main() {
  runApp(const StaticApp());
}

class StaticApp extends StatelessWidget {
  const StaticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: const DeepTree()
        // home: const ProfileScreen()
        // home: const FlexScreen());
        );
  }
}
