import 'package:flutter/material.dart';
import 'package:todolist_hive_app/db/Boxes/todoListBox.dart';
import 'package:todolist_hive_app/db/models/todoList.dart';

class TodoInput extends StatefulWidget {
  @override
  _TodoInputState createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController todosController = TextEditingController();

  void addTodo() {
    if (todosController.text.isEmpty) {
      return;
    } else {
      final todo = TodoList(todos: todosController.text);
      todoListBox.put('key_${todosController.text}', todo);
      todosController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: todosController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter something...",
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: addTodo,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
