import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/datamodel/todolistmodel.dart';

class ViewTodo extends StatefulWidget {
  final TodoListModel todoListModel;
  const ViewTodo(
      {super.key, required TripModel tripModel, required this.todoListModel});

  @override
  // ignore: library_private_types_in_public_api
  _ViewTodoState createState() => _ViewTodoState();
}

class _ViewTodoState extends State<ViewTodo> {
  List<bool> _completed = [];

  @override
  void initState() {
    super.initState();
    _completed =
        List.generate(widget.todoListModel.todolist.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          widget.todoListModel.title,
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.todoListModel.todolist.length,
          itemBuilder: (context, index) {
            final item = widget.todoListModel.todolist[index];
            return Dismissible(
              key: Key(item),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.green,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  widget.todoListModel.todolist.removeAt(index);
                  _completed.removeAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.green.shade600,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            direction == DismissDirection.endToStart
                                ? 'Task completed!'
                                : 'Task deleted!',
                          ),
                        ),
                      ],
                    ),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(30),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: _completed[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _completed[index] = value ?? false;
                        });
                      },
                    ),
                    title: Text(
                      item,
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration: _completed[index]
                            ? TextDecoration.lineThrough
                            : null,
                        color: _completed[index] ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
