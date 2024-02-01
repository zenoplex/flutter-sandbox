import 'package:flutter/material.dart';
import 'package:flutter_sandbox/flex_screen.dart';
// import 'package:flutter_sandbox/profile_screen.dart';

void main() {
  runApp(const StaticApp());
}

class StaticApp extends StatelessWidget {
  const StaticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        // home: const ProfileScreen());
        home: const FlexScreen());
  }
}
