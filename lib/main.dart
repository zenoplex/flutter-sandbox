import 'package:flutter/material.dart';
import 'package:flutter_sandbox/immutable_widget.dart';

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
        home: const ImmutableWidget());
  }
}
