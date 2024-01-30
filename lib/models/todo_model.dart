class Todo {
  final String title;
  final DateTime dueDate;
  bool isCompleted;

  Todo({required this.title, required this.dueDate, this.isCompleted = false});
}
