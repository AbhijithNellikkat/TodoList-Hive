import 'package:flutter/material.dart';
import 'package:todolist_hive_app/db/Boxes/todoListBox.dart';
import 'package:todolist_hive_app/db/models/todoList.dart';

class UpdateTodoWidget extends StatefulWidget {
  final id;
  final value;
  const UpdateTodoWidget({
    super.key,
    required this.id,
    required this.value,
  });

  @override
  _UpdateTodoWidgetState createState() => _UpdateTodoWidgetState();
}

class _UpdateTodoWidgetState extends State<UpdateTodoWidget> {
  final TextEditingController todosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    todosController.text = widget.value;
    var key = widget.id;

    void updateTodo() {
      if (todosController.text.isNotEmpty) {
        // ignore: unused_local_variable
        final todo = TodoList(todos: todosController.text);
        todoListBox.putAt(
          key,
          TodoList(todos: todosController.text),
        );
        todosController.clear();
        Navigator.pop(context);
      }
    }

    return SafeArea(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                onPressed: updateTodo,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
