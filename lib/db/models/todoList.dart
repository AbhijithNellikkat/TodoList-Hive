import 'package:hive/hive.dart';

part 'todoList.g.dart';

@HiveType(typeId: 1)
class TodoList  {
  TodoList({
    required this.todos,
  });
  @HiveField(0)
  String todos;
}
