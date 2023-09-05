import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist_hive_app/db/Boxes/todoListBox.dart';
import 'package:todolist_hive_app/db/models/todoList.dart';
import 'package:todolist_hive_app/updateTodo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController todosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Padding(
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
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListenableBuilder(
                        listenable: todoListBox.listenable(),
                        builder: (context, child) {
                          return ListView.builder(
                            itemCount: todoListBox.length,
                            itemBuilder: (context, index) {
                              final todoList = todoListBox.getAt(index);
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                elevation: 6,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return UpdateTodoWidget(
                                                  id: index,
                                                  value: todoList.todos);
                                            },
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                          'assets/todolist-image.png'),
                                    ),
                                    title: Text(
                                      todoList.todos,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          todoListBox.deleteAt(index);
                                        });
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ),
              ),
            ),
            TextButton.icon(
              // Todo List full clear
              onPressed: () {
                setState(() {
                  todoListBox.clear();
                });
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text("Delete all"),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
    setState(
      () {
        if (todosController.text.isEmpty) {
          return;
        } else {
          FocusManager.instance.primaryFocus?.unfocus();
          todoListBox.put(
            'key_$todosController.text',
            TodoList(
              todos: todosController.text,
            ),
          );
          todosController.clear();
        }
      },
    );
  }
}
