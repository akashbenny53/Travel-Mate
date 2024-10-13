import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app/datamodel/expensemodel.dart';
import 'package:travel_app/datamodel/todolistmodel.dart';
part 'tripmodel.g.dart';

@HiveType(typeId: 1)
class TripModel extends HiveObject {
  @HiveField(0)
  String place;

  @HiveField(1)
  String name;

  @HiveField(2)
  String budget;

  @HiveField(3)
  String image;

  @HiveField(4)
  DateTime? startdate;

  @HiveField(5)
  DateTime? enddate;

  @HiveField(6)
  List<TodoListModel>? todolist;

  @HiveField(7)
  ExpenseModel? expense;

  @HiveField(8)
  List<int>? journalKeys;

  TripModel(
      {required this.name,
      required this.place,
      required this.budget,
      required this.image,
      this.enddate,
      this.todolist,
      this.expense,
      this.journalKeys,
      this.startdate});
}
