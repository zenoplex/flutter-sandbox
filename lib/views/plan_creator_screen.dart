import 'package:flutter/material.dart';
import 'package:flutter_sandbox/models/data_layer.dart';
import 'package:flutter_sandbox/plan_provider.dart';
import 'package:flutter_sandbox/views/plan_screen.dart';

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
          ),
          Expanded(child: _buildPlanList()),
        ],
      ),
    );
  }

  Widget _buildPlanList() {
    final ValueNotifier<Plans> planNotifier = PlanProvider.of(context);
    final Plans(:planIds, :planMap) = planNotifier.value;

    if (planIds.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.note, size: 100, color: Colors.grey),
          Text(
            'You have no plans yet.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      );
    }

    return ListView.builder(
      itemCount: planIds.length,
      itemBuilder: (context, index) {
        final planId = planIds[index];
        final maybePlan = planMap[planId];
        assert(maybePlan != null);
        final plan = maybePlan!;

        return ListTile(
          title: Text(plan.name),
          subtitle: Text(plan.completenessMessage),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<Widget>(
                builder: (_) => PlanScreen(planId: plan.id),
              ),
            );
          },
        );
      },
    );
  }

  void _addPlan() {
    final text = _textEditingController.text;
    if (text.isEmpty) return;

    final ValueNotifier<Plans> planNotifier = PlanProvider.of(context);

    final plans = planNotifier.value;
    planNotifier.value = plans.addPlan(name: text);

    _textEditingController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
