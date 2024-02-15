class Task {
  final String id;
  final String description;
  final bool isComplete;

  const Task({
    required this.id,
    this.isComplete = false,
    this.description = '',
  });

  Task update({String? newDescription, bool? newIsComplete}) {
    return Task(
      id: id,
      description: newDescription ?? description,
      isComplete: newIsComplete ?? isComplete,
    );
  }
}
