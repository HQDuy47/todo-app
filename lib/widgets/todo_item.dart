// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:intl/intl.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;

  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);

          if (todo.isDone) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Congratulations!',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  content: Text(
                    "You've completed: ${todo.todoText}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onDeleteItem(todo.id);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone
              ? Icons.check_circle
              : Icons.radio_button_unchecked_outlined,
          color: todo.isDone
              ? const Color.fromARGB(255, 58, 167, 255)
              : const Color.fromARGB(255, 174, 174, 174),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.todoText!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            Text(
              DateFormat('yyyy-MM-dd HH:mm').format(todo.dateTime!),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
        ),
        trailing: Container(
            child: IconButton(
          onPressed: () {
            onDeleteItem(todo.id);
          },
          color: const Color.fromARGB(220, 255, 64, 71),
          icon: const Icon(Icons.delete),
          iconSize: 24,
        )),
      ),
    );
  }
}
