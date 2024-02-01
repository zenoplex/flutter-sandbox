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
        body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ..._header(context, 'Expanded'),
            const DemoExpanded(),
            ..._header(context, 'Flexible'),
            const DemoFlexible(),
            const Expanded(child: Spacer()),
            const Center(child: DemoFooter()),
          ]),
        ));
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
    return const SizedBox(
        height: 100,
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: LabeledContainer(color: Colors.orange, text: '25%')),
            Flexible(
                flex: 1,
                child: LabeledContainer(color: Colors.deepOrange, text: '25%')),
            Flexible(
                flex: 2,
                child: LabeledContainer(color: Colors.blue, text: '50%')),
          ],
        ));
  }
}

class DemoFooter extends StatelessWidget {
  const DemoFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(40)),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          'Sticky Footer',
          style: Theme.of(context).textTheme.titleSmall,
        ));
  }
}
