import 'package:animations/animations.dart';
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
          return OpenContainer(
            transitionDuration: const Duration(milliseconds: 700),
            openBuilder: (context, action) {
              return Scaffold(
                appBar: AppBar(title: Text(sweet)),
                body: const Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child:
                            Icon(Icons.cake, size: 200, color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              );
            },
            closedBuilder: (context, openContainer) {
              return Dismissible(
                key: Key(sweet),
                direction: DismissDirection.endToStart,
                background: const ColoredBox(color: Colors.red),
                // Wrapping the ListTile in Material to retain its tileColor
                // https://github.com/flutter/flutter/issues/83108
                child: Material(
                  child: ListTile(
                    title: Text(sweet),
                    onTap: () {
                      openContainer();
                    },
                  ),
                ),
                onDismissed: (direction) {
                  sweets.removeAt(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
