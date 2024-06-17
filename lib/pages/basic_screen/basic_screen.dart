import 'package:flutter/material.dart';
import 'package:flutter_sandbox/pages/basic_screen/text_layout.dart';
import 'package:flutter_sandbox/ui/drawer.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Welcome to Flutter'),
        actions: const [
          Padding(padding: EdgeInsets.all(10.0), child: Icon(Icons.edit)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            image: true,
            label: 'A beautiful beach',
            child: Image.asset('assets/beach.jpg'),
          ),
          const TextLayout(),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}