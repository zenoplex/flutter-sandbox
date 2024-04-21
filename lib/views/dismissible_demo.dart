import 'package:flutter/material.dart';

class DismissibleDemo extends StatefulWidget {
  const DismissibleDemo({super.key});

  @override
  State<DismissibleDemo> createState() => _DismissibleDemoState();
}

class _DismissibleDemoState extends State<DismissibleDemo> {
  final List<String> sweets = [
    'Petit Four',
    'Cupcake',
    'Donut',
    'Eclair',
    'Froyo',
    'Gingerbread',
    'Honeycomb',
    'Ice Cream Sandwich',
    'Jelly Bean',
    'KitKat',
    'Lollipop',
    'Marshmallow',
    'Nougat',
    'Oreo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dismissible")),
      body: ListView.builder(
        itemCount: sweets.length,
        itemBuilder: (context, index) {
          final String sweet = sweets[index];
          return Dismissible(
            key: Key(sweet),
            background: const ColoredBox(color: Colors.red),
            child: ListTile(title: Text(sweet)),
            onDismissed: (direction) {
              sweets.removeAt(index);
            },
          );
        },
      ),
    );
  }
}
