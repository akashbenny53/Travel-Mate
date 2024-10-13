import 'package:hive_flutter/hive_flutter.dart';
part 'todolistmodel.g.dart';

@HiveType(typeId: 2)
class TodoListModel {
  @HiveField(0)
  late String title;

  @HiveField(1)
  List<String> todolist;
  TodoListModel({
    required this.todolist,
    required this.title,
  });
}
