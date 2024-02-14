import 'package:flutter/material.dart';

class PlanCreatorScreen extends StatefulWidget {
  const PlanCreatorScreen({super.key});

  @override
  State<PlanCreatorScreen> createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends State<PlanCreatorScreen> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Master Plans'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                color: Theme.of(context).cardColor,
                elevation: 10,
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Add a plan',
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  onEditingComplete: _addPlan,
                ),
              ),
            )
          ],
        ));
  }

  void _addPlan() {
    print('add');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
