import './task.dart';

class Plan {
  final String name;
  final List<String> taskIds;
  final Map<String, Task> taskMap;

  const Plan({this.name = '', this.taskIds = const [], this.taskMap = const {}});
}
