import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/data_layer.dart';
import '../plan_provider.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Master plan')),
      body: ValueListenableBuilder<Plan>(
        valueListenable: PlanProvider.of(context),
        builder: (context, plan, child) {
          return _buildList(plan);
        },
      ),
      floatingActionButton: _buildActionButton(context),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildActionButton(BuildContext context) {
    ValueNotifier<Plan> planNotifier = PlanProvider.of(context);

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Plan plan = planNotifier.value;
        final id = const Uuid().v4();
        planNotifier.value = Plan(
          name: plan.name,
          taskIds: [...plan.taskIds, id],
          taskMap: {...plan.taskMap, id: Task(id: id)},
        );
      },
    );
  }

  Widget _buildList(Plan plan) {
    return Scrollbar(
      controller: _scrollController,
      child: ListView.builder(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ClampingScrollPhysics(),
        itemCount: plan.taskIds.length,
        itemBuilder: (context, index) {
          final id = plan.taskIds[index];
          final maybeTask = plan.taskMap[id];

          assert(maybeTask != null, 'Task $id not found in plan');

          final task = maybeTask!;

          return _buildTaskTile(context, task, id, index);
        },
      ),
    );
  }

  Widget _buildTaskTile(BuildContext context, Task task, String id, int index) {
    ValueNotifier<Plan> planNotifier = PlanProvider.of(context);
    return ListTile(
      leading: Checkbox(
          value: task.isComplete,
          onChanged: (value) {
            Plan plan = planNotifier.value;
            planNotifier.value = Plan(
              name: plan.name,
              taskIds: plan.taskIds,
              taskMap: {
                ...plan.taskMap,
                id: Task(
                  id: id,
                  description: task.description,
                  isComplete: value ?? false,
                )
              },
            );
          }),
      title: TextFormField(
        initialValue: task.description,
        decoration: InputDecoration(
          hintText: 'Enter task ${index + 1}',
        ),
        onChanged: (value) {
          Plan plan = planNotifier.value;
          plan = Plan(
            name: plan.name,
            taskIds: plan.taskIds,
            taskMap: {
              ...plan.taskMap,
              id: Task(
                id: id,
                description: value,
                isComplete: task.isComplete,
              ),
            },
          );
        },
      ),
    );
  }
}
