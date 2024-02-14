import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/data_layer.dart';
import '../plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Master plan')),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          // TODO: Should not have to find the plan by name
          Plan currentPlan =
              plans.firstWhere((p) => p.name == widget.plan.name);
          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
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
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // TODO: Should not have to find the plan by name
        Plan currentPlan = planNotifier.value.firstWhere(
          (p) => p.name == widget.plan.name,
        );
        int planIndex =
            planNotifier.value.indexWhere((p) => p.name == currentPlan.name);
        final id = const Uuid().v4();

        planNotifier.value = List<Plan>.from(planNotifier.value)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            taskIds: [...currentPlan.taskIds, id],
            taskMap: {
              ...currentPlan.taskMap,
              id: Task(id: id),
            },
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
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    return ListTile(
      leading: Checkbox(
          value: task.isComplete,
          onChanged: (value) {
            // TODO: Should not have to find the plan by name
            Plan currentPlan = planNotifier.value.firstWhere(
              (p) => p.name == widget.plan.name,
            );
            int planIndex = planNotifier.value.indexWhere(
              (p) => p.name == currentPlan.name,
            );
            planNotifier.value = List<Plan>.from(planNotifier.value)
              ..[planIndex] = Plan(
                name: currentPlan.name,
                taskIds: currentPlan.taskIds,
                taskMap: {
                  ...currentPlan.taskMap,
                  id: Task(
                    id: id,
                    description: task.description,
                    isComplete: value ?? false,
                  ),
                },
              );
          }),
      title: TextFormField(
        initialValue: task.description,
        decoration: InputDecoration(
          hintText: 'Enter task ${index + 1}',
        ),
        onChanged: (value) {
          // TODO: Should not have to find the plan by name
          Plan currentPlan = planNotifier.value.firstWhere(
            (p) => p.name == widget.plan.name,
          );
          int planIndex = planNotifier.value.indexWhere(
            (p) => p.name == currentPlan.name,
          );
          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              taskIds: currentPlan.taskIds,
              taskMap: {
                ...currentPlan.taskMap,
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
