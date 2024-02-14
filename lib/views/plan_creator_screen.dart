import 'package:flutter/material.dart';
import '../plan_provider.dart';
import '../views/plan_screen.dart';
import '../models/plan.dart';

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
        ));
  }

  Widget _buildPlanList() {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    List<Plan> plans = planNotifier.value;

    if (plans.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.note, size: 100, color: Colors.grey),
          Text('You have no plans yet.',
              style: Theme.of(context).textTheme.headlineSmall),
        ],
      );
    }

    return ListView.builder(
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return ListTile(
          title: Text(plan.name),
          subtitle: Text(plan.completenessMessage),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlanScreen(plan: plan),
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

    final plan = Plan(
      name: text,
    );
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);
    planNotifier.value = List<Plan>.from(planNotifier.value)..add(plan);

    _textEditingController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
