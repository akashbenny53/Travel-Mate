import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/database/trip.dart';
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
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        title: Text(
          'To Do List',
          style: GoogleFonts.lato(
            fontSize: 24,
            fontWeight: FontWeight.w600,
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
          : ListView.builder(
              itemCount: tripModel.todolist!.length,
              itemBuilder: (context, index) {
                final todolist = tripModel.todolist![index];
                return Slidable(
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                'Are you sure that you want to delete this todo?',
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
                        foregroundColor: Colors.redAccent,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    elevation: 4,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(20),
                      leading: Icon(
                        Icons.checklist_rounded,
                        color: Colors.green.shade600,
                        size: 40,
                      ),
                      title: Text(
                        todolist.title,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        todolist.todolist.length > 50
                            ? '${todolist.todolist.join(', ').substring(0, 50)}...'
                            : todolist.todolist.join(', '),
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewTodo(
                              tripModel: tripModel,
                              todoListModel: todolist,
                            ),
                          ),
                        ).then((value) {
                          if (value != null) {
                            tripModel = value;
                          }
                          setState(() {});
                        });
                      },
                    ),
                  ),
                );
              },
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
