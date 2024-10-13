import 'package:hive_flutter/hive_flutter.dart';
part 'journalmodel.g.dart';

@HiveType(typeId: 4)
class JournalModel {
  @HiveField(0)
  String content;

  JournalModel({required this.content});
}
