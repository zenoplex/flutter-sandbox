import 'package:uuid/uuid.dart';

import './task.dart';

class Plan {
  final String id;
  final String name;
  final List<String> taskIds;
  final Map<String, Task> taskMap;

  const Plan({
    required this.id,
    this.name = '',
    this.taskIds = const [],
    this.taskMap = const {},
  });

  int get completedCount {
    return taskIds.fold(0, (previousValue, element) {
      final maybeTask = taskMap[element];
      assert(maybeTask != null, 'Task $element not found in plan');
      final task = maybeTask!;

      if (task.isComplete) {
        return previousValue + 1;
      }
      return previousValue;
    });
  }

  String get completenessMessage =>
      '$completedCount out of ${taskIds.length} tasks.';

  Plan addTask() {
    final taskId = const Uuid().v4();
    return Plan(
      id: id,
      name: name,
      taskIds: [...taskIds, taskId],
      taskMap: {
        ...taskMap,
        taskId: Task(id: taskId),
      },
    );
  }

  Plan updateTask(
      {required String taskId, String? description, bool? isComplete}) {
    final maybeTask = taskMap[taskId];
    assert(maybeTask != null, 'Task $taskId not found in plan');
    final task = maybeTask!;

    return Plan(
      id: id,
      name: name,
      taskIds: taskIds,
      taskMap: {
        ...taskMap,
        taskId: task.update(
          newDescription: description,
          newIsComplete: isComplete,
        )
      },
    );
  }
}
