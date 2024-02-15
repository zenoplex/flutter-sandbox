import 'package:uuid/uuid.dart';
import './plan.dart';

class Plans {
  final List<String> planIds;
  final Map<String, Plan> planMap;

  const Plans({
    this.planIds = const [],
    this.planMap = const {},
  });

  Plans addPlan({required String name}) {
    final plan = Plan(
      id: const Uuid().v4(),
      name: name,
    );

    return Plans(
      planIds: [...planIds, plan.id],
      planMap: {
        ...planMap,
        plan.id: plan,
      },
    );
  }
}
