import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/database/trip.dart';
import 'package:travel_app/datamodel/todolistmodel.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/screens/createtodolist.dart';
import 'package:travel_app/screens/viewtodolist.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatefulWidget {
  final TripModel trip;
  const TodoList({super.key, required this.trip});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late TripModel tripModel;
  @override
  void initState() {
    tripModel = widget.trip;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text(
          'To Do List',
          style: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: tripModel.todolist == null || tripModel.todolist!.isEmpty
          ? Center(
              child: Text(
                'Empty',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ListView(
              children: [
                ...tripModel.todolist!.map(
                  (todolist) => Slidable(
                    startActionPane: ActionPane(
                      motion: const StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Text(
                                  'Are you sure that you want to delete this todo ?',
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.green.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        tripModel.todolist?.remove(todolist);
                                        TripDb cd = TripDb();
                                        await cd
                                            .editUser(tripModel.key, tripModel)
                                            .then(
                                          (value) {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                        // ignore: empty_catches
                                      } catch (e) {}
                                      setState(() {});
                                    },
                                    child: Text(
                                      'Yes',
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.green.shade600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          backgroundColor: Colors.white24,
                          foregroundColor: Colors.black,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Card(
                      key: const ValueKey(0),
                      color: Colors.green.shade600,
                      margin: const EdgeInsets.all(13),
                      elevation: 3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewTodo(
                                tripModel: tripModel,
                                todoListModel: TodoListModel(
                                  todolist: todolist.todolist,
                                  title: todolist.title,
                                ),
                              ),
                            ),
                          ).then(
                            (value) {
                              if (value != null) {
                                tripModel = value;
                              }
                              setState(() {});
                            },
                          );
                        },
                        child: ListTile(
                          title: Text(
                            todolist.title,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        label: Text(
          'Add new todo',
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.green.shade600,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTodo(
                tripModel: tripModel,
              ),
            ),
          ).then(
            (value) {
              if (value != null) {
                tripModel = value;
              }
              setState(() {});
            },
          );
        },
        icon: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
