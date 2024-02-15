import './plan.dart';

class Plans {
  final List<String> planIds;
  final Map<String, Plan> planMap;

  const Plans({
    this.planIds = const [],
    this.planMap = const {},
  });
}
