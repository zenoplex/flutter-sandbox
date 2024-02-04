import 'package:flutter/material.dart';
// import 'package:flutter_sandbox/flex_screen.dart';
// import 'package:flutter_sandbox/profile_screen.dart';
// import 'package:flutter_sandbox/deep_tree.dart';
import 'package:flutter_sandbox/e_commerce_screen.dart';

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
        primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
        ),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      home: const ECommerceScreen(),
      // home: const DeepTree()
      // home: const ProfileScreen()
      // home: const FlexScreen());
    );
  }
}
