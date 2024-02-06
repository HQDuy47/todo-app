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

  // Phương thức tạo danh sách các ToDo mẫu
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
      // Thêm các ToDo mẫu khác nếu cần
    ];
  }

  // Phương thức chuyển đổi từ dữ liệu JSON thành đối tượng ToDo
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      todoText: json['todoText'],
      dateTime:
          json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
      isDone: json['isDone'] ?? false,
    );
  }

  // Phương thức chuyển đổi từ đối tượng ToDo thành dữ liệu JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todoText': todoText,
      'dateTime': dateTime?.toIso8601String(),
      'isDone': isDone,
    };
  }
}
