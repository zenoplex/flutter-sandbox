import 'package:flutter/material.dart';

class NavigationDialog extends StatefulWidget {
  const NavigationDialog({super.key});

  @override
  State<NavigationDialog> createState() => _NavigationDialogState();
}

class _NavigationDialogState extends State<NavigationDialog> {
  Color color = Colors.blue.shade700;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color,
        appBar: AppBar(title: const Text('Navigation Dialog')),
        body: Center(
          child: ElevatedButton(
            child: const Text('Change Color'),
            onPressed: () {
              _showColorDialog(context);
            },
          ),
        ));
  }

  _showColorDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (_) {
          return const AlertDialog(
              title: Text('Pick a color'),
              content: Text('Color picker goes here!'),
              actions: []);
        });
  }
}
