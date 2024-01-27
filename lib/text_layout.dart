import 'package:flutter/material.dart';

class TextLayout extends StatelessWidget {
  const TextLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hello World!',
          style: TextStyle(fontSize: 30),
        ),
        Text('Text can wrap without issue',
            style: Theme.of(context).textTheme.titleLarge),
        const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut fermentum ante eu sapien tincidunt, eu pulvinar eros pharetra. Vestibulum non efficitur magna, vel interdum dui. Donec consectetur lorem purus, sit amet consequat sapien dignissim vel. ')
      ],
    );
  }
}
