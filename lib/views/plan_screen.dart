import 'package:flutter/material.dart';
import '../models/data_layer.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  // TODO: temporary height
  final double _itemExtent = 50.0;
  Plan plan = const Plan();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master plan')),
      body: _buildList(),
      floatingActionButton: _buildActionButton(),
    );
  }

  Widget _buildActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          plan = Plan(
            name: plan.name,
            tasks: [...plan.tasks, const Task()],
          );
        });
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: plan.tasks.length,
      itemExtent: _itemExtent,
      itemBuilder: (context, index) => const Placeholder(),
    );
  }
}
