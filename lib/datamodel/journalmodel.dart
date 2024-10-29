import 'package:hive_flutter/hive_flutter.dart';
part 'journalmodel.g.dart';

@HiveType(typeId: 4)
class JournalModel {
  @HiveField(0)
  String content;

  @HiveField(1)
  List<String>? imagePaths;

  @HiveField(2)
  DateTime date;

  JournalModel({
    required this.content,
    this.imagePaths,
    required this.date,
  });
}
