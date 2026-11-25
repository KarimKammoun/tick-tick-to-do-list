/// Status of a task (spec section 4): todo, done or abandoned.
enum TaskStatus {
  todo,
  done,
  abandoned;

  static TaskStatus fromName(String name) {
    return TaskStatus.values.firstWhere(
      (TaskStatus status) => status.name == name,
      orElse: () => TaskStatus.todo,
    );
  }
}
