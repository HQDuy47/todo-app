import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:todo_app/widgets/todo_date.dart';
import 'package:todo_app/widgets/todo_noti.dart';
import 'package:todo_app/widgets/todo_search.dart';
import 'package:todo_app/widgets/todo_time.dart';
import 'package:todo_app/widgets/todo_appBar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> todoList = [];
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  int myIndex = 0;

  @override
  void initState() {
    _loadToDoList();
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
    Noti.createNotificationChannel(flutterLocalNotificationsPlugin);
  }

  void _loadToDoList() async {
    List<ToDo> storedToDoList = await getToDoListFromStorage();
    setState(() {
      todoList = storedToDoList;
      _foundToDo = storedToDoList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 252),
      appBar: const MyAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(children: [
              SearchBox(onSearchChanged: _runFilter),
              Expanded(
                child: ListView(
                  children: [
                    if (myIndex != 2 || myIndex == 0)
                      ..._buildTaskColumn(
                          'Today',
                          (todo) => isToday(todo.dateTime!),
                          'No task for today'),
                    if (myIndex != 1 || myIndex == 0)
                      ..._buildTaskColumn(
                          'Upcoming',
                          (todo) => isUpcoming(todo.dateTime!),
                          'No upcoming tasks'),
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _showAddTodoModal();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(220, 255, 64, 71),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
        currentIndex: myIndex,
        selectedItemColor: const Color.fromARGB(220, 255, 64, 71),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "All"),
          BottomNavigationBarItem(
              icon: Icon(Icons.today_rounded), label: "Today"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded), label: "Upcoming"),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      saveToDoListToStorage(todoList);
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
      saveToDoListToStorage(todoList);
    });
  }

  void _addToDoItem(String toDo, DateTime selectedDateTime) {
    setState(() {
      todoList.add(
        ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          todoText: toDo,
          dateTime: selectedDateTime,
        ),
      );
      saveToDoListToStorage(todoList);
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  bool isUpcoming(DateTime dateTime) {
    final now = DateTime.now();
    return dateTime.year > now.year ||
        (dateTime.year == now.year &&
            (dateTime.month > now.month ||
                (dateTime.month == now.month && dateTime.day > now.day)));
  }

  Future<void> saveToDoListToStorage(List<ToDo> list) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = list.map((todo) => todo.toJson()).toList();
    await prefs.setString('todo_list', json.encode(encodedData));
  }

  Future<List<ToDo>> getToDoListFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final todoData = prefs.getString('todo_list');
    if (todoData != null) {
      final decodedData = json.decode(todoData) as List<dynamic>;
      return decodedData.map((todoJson) => ToDo.fromJson(todoJson)).toList();
    } else {
      return [];
    }
  }

  void _showAddTodoModal() async {
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();

    // Tạo một FocusNode
    FocusNode focusNode = FocusNode();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(focusNode);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              children: [
                TextField(
                  controller: _todoController,
                  focusNode: focusNode,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Enter your ToDo...",
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  autocorrect: false,
                  enableSuggestions: false,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: MyDate(
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyTime(
                        onTimeSelected: (pickedTime) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      DateTime selectedDateTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        selectedTime!.hour,
                        selectedTime!.minute,
                      );

                      Noti.scheduleNotification(
                        id: 1,
                        title: "Scheduled Notification",
                        body: _todoController.text,
                        scheduledDate: selectedDateTime,
                        fln: flutterLocalNotificationsPlugin,
                      );

                      _addToDoItem(_todoController.text, selectedDateTime);

                      _todoController.clear();

                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Error',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            content: const Text(
                              'Please fill in all fields.',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Color.fromARGB(220, 255, 64, 71),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(220, 255, 64, 71),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    elevation: 10,
                  ),
                  child: const Text("Add ToDo"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _validateInputs() {
    return _todoController.text.isNotEmpty &&
        selectedDate != null &&
        selectedTime != null;
  }

  List<Widget> _buildTaskColumn(
      String title, bool Function(ToDo) filterCondition, String noTaskMessage) {
    List<ToDo> filteredTasks = _foundToDo.where(filterCondition).toList();

    return [
      if (filteredTasks.isNotEmpty) ...[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            for (ToDo todo in filteredTasks.reversed)
              ToDoItem(
                todo: todo,
                onToDoChanged: _handleToDoChange,
                onDeleteItem: _deleteToDoItem,
              ),
          ],
        )
      ] else
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 20),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  noTaskMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
    ];
  }
}
