import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
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
          final id = const Uuid().v4();
          plan = Plan(
            name: plan.name,
            taskIds: [...plan.taskIds, id],
            taskMap: {...plan.taskMap, id: Task(id: id)},
          );
        });
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: plan.taskIds.length,
      itemExtent: _itemExtent,
      itemBuilder: (context, index) {
        final id = plan.taskIds[index];
        final maybeTask = plan.taskMap[id];

        assert(maybeTask != null, 'Task $id not found in plan');

        final task = maybeTask!;

        return ListTile(
          leading: Checkbox(
              value: task.isComplete,
              onChanged: (value) {
                setState(() {
                  plan = Plan(name: plan.name, taskIds: plan.taskIds, taskMap: {
                    ...plan.taskMap,
                    id: Task(
                        id: id,
                        description: task.description,
                        isComplete: value ?? false)
                  });
                });
              }),
          title: TextFormField(
            initialValue: task.description,
            onChanged: (value) {
              setState(() {
                plan = Plan(
                  name: plan.name,
                  taskIds: plan.taskIds,
                  taskMap: {
                    ...plan.taskMap,
                    id: Task(
                        id: id,
                        description: value,
                        isComplete: task.isComplete),
                  },
                );
              });
            },
          ),
        );
      },
    );
  }
}
