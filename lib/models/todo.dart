class ToDo {
  final String id;
  final String? todoText;
  final DateTime? dateTime;
  bool isDone;

  ToDo({
    required this.id,
    this.todoText,
    this.dateTime,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '1',
        todoText: 'Task 1',
        dateTime: DateTime.now(),
        isDone: false,
      ),
      ToDo(
        id: '2',
        todoText: 'Task 2',
        dateTime: DateTime.now(),
        isDone: false,
      ),
    ];
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      dateTime:
          json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'dateTime': dateTime?.toIso8601String(),
      'isDone': isDone,
    };
  }
}
