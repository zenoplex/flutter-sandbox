import 'package:flutter/material.dart';

class NavigationDialog extends StatefulWidget {
  const NavigationDialog({super.key});

  @override
  State<NavigationDialog> createState() => _NavigationDialogState();
}

class _NavigationDialogState extends State<NavigationDialog> {
  Color? color = Colors.blue.shade700;

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
      ),
    );
  }

  Future<void> _showColorDialog(BuildContext context) async {
    color = await showDialog<Color>(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: const Text('Color picker goes here!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, Colors.red.shade700);
              },
              child: const Text('Red'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, Colors.green.shade700);
              },
              child: const Text('Green'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, Colors.blue.shade700);
              },
              child: const Text('Blue'),
            ),
          ],
        );
      },
    );
    setState(() {});
  }
}
