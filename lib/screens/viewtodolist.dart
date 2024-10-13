import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/datamodel/todolistmodel.dart';

class ViewTodo extends StatelessWidget {
  final TodoListModel todoListModel;
  const ViewTodo(
      {super.key, required TripModel tripModel, required this.todoListModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          todoListModel.title,
          style: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: todoListModel.todolist.length,
          itemBuilder: (
            context,
            index,
          ) =>
              Padding(
            padding: const EdgeInsets.fromLTRB(65, 0, 20, 30),
            child: Text(
              todoListModel.todolist[index],
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
