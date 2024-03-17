import 'package:flutter/material.dart';
import 'package:flutter_sandbox/number_stream.dart';

class StreamBuilderApp extends StatefulWidget {
  const StreamBuilderApp({super.key});

  @override
  State<StreamBuilderApp> createState() => _StreamBuilderAppState();
}

class _StreamBuilderAppState extends State<StreamBuilderApp> {
  final Stream<int> numberStream = NumberStream().getNumbers();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: Container(),
    );
  }
}
