import 'package:flutter/material.dart';

class JsonHomePage extends StatefulWidget {
  const JsonHomePage({super.key});

  @override
  State<JsonHomePage> createState() => _JsonHomePageState();
}

class _JsonHomePageState extends State<JsonHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON'),
      ),
      body: Container(),
    );
  }
}
