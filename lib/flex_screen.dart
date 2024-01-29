import 'package:flutter/material.dart';

class FlexScreen extends StatelessWidget {
  const FlexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexible and Expanded'),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [..._header(context, 'Expanded')]),
    );
  }

  Iterable _header(BuildContext context, String text) {
    return [
      const SizedBox(height: 20),
      Text(text, style: Theme.of(context).textTheme.headlineSmall),
    ];
  }
}
