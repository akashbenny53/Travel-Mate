import 'package:hive_flutter/hive_flutter.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 5)
class UserModel {
  @HiveField(0)
  String user;

  @HiveField(1)
  String profile;

  UserModel({required this.user, required this.profile});
}
