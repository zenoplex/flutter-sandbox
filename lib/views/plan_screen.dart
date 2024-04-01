import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/data_layer.dart';
import 'package:flutter_sandbox/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final String planId;

  const PlanScreen({super.key, required this.planId});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Plans> plansNotifier = PlanProvider.of(context);
    final maybePlan = plansNotifier.value.planMap[widget.planId];
    assert(maybePlan != null, 'Plan ${widget.planId} not found');
    final currentPlan = maybePlan!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${currentPlan.name} plan'),
      ),
      body: ValueListenableBuilder<Plans>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          final maybePlan = plans.planMap[widget.planId];
          assert(maybePlan != null, 'Plan ${widget.planId} not found');
          final currentPlan = maybePlan!;

          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(child: Text(currentPlan.completenessMessage)),
            ],
          );
        },
      ),
      floatingActionButton: _buildActionButton(
        context,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildActionButton(BuildContext context) {
    final ValueNotifier<Plans> plansNotifier = PlanProvider.of(context);

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final currentPlan = plansNotifier.value.planMap[widget.planId]!;

        plansNotifier.value = Plans(
          planIds: plansNotifier.value.planIds,
          planMap: {
            ...plansNotifier.value.planMap,
            widget.planId: currentPlan.addTask(),
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
    final ValueNotifier<Plans> plansNotifier = PlanProvider.of(context);
    return ListTile(
      leading: Checkbox(
        value: task.isComplete,
        onChanged: (value) {
          final currentPlan = plansNotifier.value.planMap[widget.planId]!;

          plansNotifier.value = Plans(
            planIds: plansNotifier.value.planIds,
            planMap: {
              ...plansNotifier.value.planMap,
              widget.planId:
                  currentPlan.updateTask(taskId: task.id, isComplete: value),
            },
          );
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        decoration: InputDecoration(
          hintText: 'Enter task ${index + 1}',
        ),
        onChanged: (value) {
          final currentPlan = plansNotifier.value.planMap[widget.planId]!;
          plansNotifier.value = Plans(
            planIds: plansNotifier.value.planIds,
            planMap: {
              ...plansNotifier.value.planMap,
              widget.planId:
                  currentPlan.updateTask(taskId: task.id, description: value),
            },
          );
        },
      ),
    );
  }
}
