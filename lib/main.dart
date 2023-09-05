import 'package:flutter/material.dart';
import 'package:todolist_hive_app/db/Boxes/todoListBox.dart';
import 'package:todolist_hive_app/db/models/todoList.dart';
import 'package:todolist_hive_app/homePage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {

  // Initialize 
  await Hive.initFlutter();

  // registerAdapter 
  Hive.registerAdapter(TodoListAdapter());

  // open Box 
   todoListBox = await Hive.openBox<TodoList>('todoListBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List with Hive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}
