import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/datamodel/todolistmodel.dart';
import 'package:travel_app/datamodel/tripmodel.dart';

import '../database/trip.dart';

class CreateTodo extends StatefulWidget {
  final TripModel tripModel;
  const CreateTodo({super.key, required this.tripModel});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController titlecontroller = TextEditingController();
  Map<int, String> todos = {};
  late Widget textField;
  List<Widget> todosTextfield = [];
  FocusNode focusNode = FocusNode();
  TextEditingController todolistcontroller = TextEditingController();

  late TripModel tripModel;
  @override
  void initState() {
    tripModel = widget.tripModel;
    textField = todo(FocusNode(), todosTextfield, todos);
    todosTextfield.add(textField);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade600,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, tripModel);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            'Create Todo List',
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // ignore: unused_local_variable
                if (todos.values.isNotEmpty &&
                    todos.values.first.trim().isNotEmpty) {
                  TodoListModel todoListModel = TodoListModel(
                    title: titlecontroller.text,
                    todolist: todos.values.toList(),
                  );

                  tripModel.todolist ??= [];
                  tripModel.todolist?.add(todoListModel);
                  await TripDb().editUser(tripModel.key, tripModel).then(
                    (value) {
                      var snackbar = SnackBar(
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
                                'Todo List saved successfully!',
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
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
                      );
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      });
                      Navigator.of(context).pop(tripModel);
                    },
                  );
                } else {
                  var snackbar = SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.not_interested_sharp,
                          color: Colors.red,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Please write.....',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
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
                  );
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  });
                }
              },
              icon: const Icon(
                Icons.check,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: titlecontroller,
                      autofocus: true,
                      focusNode: focusNode,
                      minLines: 1,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              ...todosTextfield
            ],
          ),
        ),
      ),
    );
  }

  Widget todo(FocusNode focusNode, List<Widget> todosTextfield,
      Map<int, String> todos) {
    int index = todos.length + 1;
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.circle,
            size: 10,
          ),
        ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              todos[index] = value;
            },
            onSubmitted: (value) {
              log('e');
              todosTextfield.add(
                todo(FocusNode(), todosTextfield, todos),
              );

              setState(() {});
            },
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'To do List',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>(
          'titlecontroller', titlecontroller),
    );
  }
}
