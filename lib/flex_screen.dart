import 'package:flutter/material.dart';
import 'package:flutter_sandbox/labeled_container.dart';

class FlexScreen extends StatelessWidget {
  const FlexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flexible and Expanded'),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ..._header(context, 'Expanded'),
        const DemoExpanded(),
        ..._header(context, 'Flexible'),
        const DemoFlexible()
      ]),
    );
  }

  Iterable _header(BuildContext context, String text) {
    return [
      const SizedBox(height: 20),
      Text(text, style: Theme.of(context).textTheme.headlineSmall),
    ];
  }
}

class DemoExpanded extends StatelessWidget {
  const DemoExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 100,
        child: Row(
          children: [
            LabeledContainer(width: 100, color: Colors.green, text: '100'),
            Expanded(
                child: LabeledContainer(
              color: Colors.purple,
              text: 'Expanded',
              textColor: Colors.white,
            )),
            LabeledContainer(width: 40, color: Colors.green, text: '40'),
          ],
        ));
  }
}

class DemoFlexible extends StatelessWidget {
  const DemoFlexible({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DemoFooter extends StatelessWidget {
  const DemoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
