import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import 'todo_form.dart';

class TodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO App'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          List<Todo> todos = todoProvider.todos;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todos[index].title),
                subtitle: Text(todos[index].dueDate.toString()),
                trailing: Checkbox(
                  value: todos[index].isCompleted,
                  onChanged: (value) {
                    todoProvider.markAsCompleted(index);
                  },
                ),
                onLongPress: () {
                  todoProvider.removeTodo(index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoForm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
