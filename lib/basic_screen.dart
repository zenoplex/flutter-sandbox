import 'package:flutter/material.dart';
import 'package:flutter_sandbox/immutable_widget.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Flutter'), actions: const [
        Padding(padding: EdgeInsets.all(10.0), child: Icon(Icons.edit))
      ]),
      backgroundColor: Colors.indigo,
      body: const Center(
          child: AspectRatio(aspectRatio: 1.0, child: ImmutableWidget())),
      drawer: Drawer(
          child: Container(
              color: Colors.lightBlue,
              child: const Center(
                child: Text("I'm a Drawer!"),
              ))),
    );
  }
}
