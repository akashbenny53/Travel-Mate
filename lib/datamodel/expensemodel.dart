import 'package:hive_flutter/hive_flutter.dart';
part 'expensemodel.g.dart';

@HiveType(typeId: 3)
class ExpenseModel {
  @HiveField(0)
  late String food;

  @HiveField(1)
  late String travelfare;

  @HiveField(2)
  late String clothes;

  @HiveField(3)
  late String stay;

  @HiveField(4)
  late String medicine;

  @HiveField(5)
  late String other;

  ExpenseModel(
      {required this.food,
      required this.travelfare,
      required this.clothes,
      required this.stay,
      required this.medicine,
      required this.other});
}
