class ToDo {
  String? id;
  String? todoText;
  DateTime? dateTime;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    required this.dateTime,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
          id: '01',
          todoText: 'Morning Excercise',
          dateTime: DateTime(2024, 2, 1, 8, 0),
          isDone: false),
      ToDo(
          id: '02',
          todoText: 'Buy Groceries',
          dateTime: DateTime(2024, 2, 1, 12, 0),
          isDone: true),
      ToDo(
          id: '03',
          todoText: 'Check Emails',
          dateTime: DateTime(2024, 2, 1, 15, 30),
          isDone: true),
      ToDo(
          id: '04',
          todoText: 'Team Meeting',
          dateTime: DateTime(2024, 2, 1, 10, 0),
          isDone: false),
      ToDo(
          id: '05',
          todoText: 'Work on mobile apps for 2 hour',
          dateTime: DateTime(2024, 2, 1, 13, 0),
          isDone: true),
      ToDo(
          id: '06',
          todoText: 'Dinner with Jenny',
          dateTime: DateTime(2024, 2, 1, 19, 0),
          isDone: false),
    ];
  }
}
