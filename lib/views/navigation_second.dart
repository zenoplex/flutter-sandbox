import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
        ),
      ),
    );
  }
}
