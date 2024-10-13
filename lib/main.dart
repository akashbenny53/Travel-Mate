import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_app/datamodel/expensemodel.dart';
import 'package:travel_app/datamodel/journalmodel.dart';
import 'package:travel_app/datamodel/todolistmodel.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/datamodel/usermodel.dart';
import 'package:travel_app/screens/splash.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TripModelAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(TodoListModelAdapter());
  Hive.registerAdapter(JournalModelAdapter());
  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox<JournalModel>('journalBox');

  runApp(const TravelMate());
}

class TravelMate extends StatelessWidget {
  const TravelMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Mate',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.green.shade300,
          selectionHandleColor: Colors.green.shade600,
        ),
        // brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: const SplaSh(),
      // darkTheme: ThemeData(
      //   brightness: Brightness.dark,
      // ),
      // themeMode: ThemeMode.system,
    );
  }
}
