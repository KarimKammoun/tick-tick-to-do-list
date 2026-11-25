/// Priority of a task (spec 5.2): 0 none, 1 low, 2 medium, 3 high.
enum TaskPriority {
  none(0),
  low(1),
  medium(2),
  high(3);

  const TaskPriority(this.value);

  /// Value stored in the database (`tasks.priority`).
  final int value;

  static TaskPriority fromValue(int value) {
    return TaskPriority.values.firstWhere(
      (TaskPriority priority) => priority.value == value,
      orElse: () => TaskPriority.none,
    );
  }
}
