import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:travel_app/datamodel/usermodel.dart';

ValueNotifier<UserModel?> usernotifier = ValueNotifier(null);

class UserDb extends ChangeNotifier {
  var box1 = Hive.openBox<UserModel>('user');
  Future<void> addUser(UserModel user) async {
    var box = await box1;
    await box.add(user);
    await getUser();
  }

  Future getUser() async {
    var box = await box1;
    if (box.isNotEmpty) {
      usernotifier.value = box.values.toList()[0];
      usernotifier.notifyListeners();
    }
  }

  Future editUser(UserModel user) async {
    var box = await box1;
    await box.put(0, user);
    await getUser();
  }
}
