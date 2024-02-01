// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: const MyAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 20),
                      child: const Text(
                        'All Todos',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    for (ToDo todo in _foundToDo.reversed)
                      ToDoItem(
                        todo: todo,
                        onToDoChanged: _handleToDoChange,
                        onDeleteItem: _deleteToDoItem,
                      ),
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
                // Expanded(
                //   child: Container(
                //     margin: const EdgeInsets.only(
                //       bottom: 20,
                //       right: 20,
                //       left: 20,
                //     ),
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 20,
                //       vertical: 5,
                //     ),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       boxShadow: const [
                //         BoxShadow(
                //           color: Colors.grey,
                //           offset: Offset(0.0, 0.0),
                //           blurRadius: 10.0,
                //           spreadRadius: 0.0,
                //         ),
                //       ],
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: TextField(
                //       controller: _todoController,
                //       decoration: const InputDecoration(
                //         hintText: "Add new todo item",
                //         border: InputBorder.none,
                //       ),
                //     ),
                //   ),
                // ),

                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // _addToDoItem(_todoController.text);
                      _showAddTodoModal();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    // setState(
    //   () {
    //     todoList.add(
    //       ToDo(
    //         id: DateTime.now().microsecondsSinceEpoch.toString(),
    //         todoText: toDo,
    //       ),
    //     );
    //   },
    // );
    // _todoController.clear();
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

  void _showAddTodoModal() async {
    DateTime? selectedDate = DateTime.now();
    TimeOfDay? selectedTime = TimeOfDay.now();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height *
              0.6, // Increased height to accommodate date and time pickers
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                "Add Todo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                  hintText: "Enter your ToDo",
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Date Picker
                  ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 8),
                        // Check if selectedDate is not null before using it
                        Text(
                          selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : "Pick Date",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Time Picker
                  ElevatedButton(
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime != null && pickedTime != selectedTime) {
                        setState(() {
                          selectedTime = pickedTime;
                        });
                      }
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.access_alarm),
                        SizedBox(
                            width:
                                8), // Add some spacing between the icon and text
                        Text("Pick Time"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Access selectedDate and selectedTime for your logic
                  // selectedDate is a DateTime and selectedTime is a TimeOfDay
                  // Combine them to get the complete date and time.

                  // Example:
                  // DateTime selectedDateTime = DateTime(
                  //   selectedDate.year,
                  //   selectedDate.month,
                  //   selectedDate.day,
                  //   selectedTime.hour,
                  //   selectedTime.minute,
                  // );

                  // Add your logic to handle the addition of ToDo
                  // _addToDoItem(_todoController.text, selectedDateTime);

                  // Close the modal
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tdBlue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(60, 60),
                  elevation: 10,
                ),
                child: const Text("Add ToDo"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          // ignore: sized_box_for_whitespace
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Image(
                image: AssetImage('images/profile.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
