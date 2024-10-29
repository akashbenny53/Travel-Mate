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
  // Controllers and FocusNodes
  final TextEditingController titleController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  // State variables
  Map<int, String> todos = {};
  late TripModel tripModel;
  late Widget initialTodoField;
  List<Widget> todoTextFields = [];

  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;
    initialTodoField = _buildTodoField(focusNode, todoTextFields, todos);
    todoTextFields.add(initialTodoField);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.green.shade600,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, tripModel),
      ),
      title: Text(
        'Create Todo List',
        style: GoogleFonts.lato(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.check,
          ),
          onPressed: _saveTodoList,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            _buildTitleInputField(),
            ...todoTextFields,
          ],
        ),
      ),
    );
  }

  // Builds the title input field
  Widget _buildTitleInputField() {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: TextField(
                controller: titleController,
                focusNode: focusNode,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  labelText: 'Todo List Title',
                  labelStyle: GoogleFonts.lato(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade900,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Builds each individual to-do input field
  Widget _buildTodoField(FocusNode focusNode, List<Widget> todoTextFields,
      Map<int, String> todos) {
    int index = todos.length + 1;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              Icons.circle,
              size: 14,
              color: Colors.green.shade600,
            ),
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              onChanged: (value) => todos[index] = value,
              onSubmitted: (_) => setState(
                () => todoTextFields.add(
                  _buildTodoField(FocusNode(), todoTextFields, todos),
                ),
              ),
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Enter a task',
                hintStyle: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.black,
            ),
            onPressed: () => setState(() {
              todos.remove(index);
              todoTextFields.removeAt(index - 1);
            }),
          ),
        ],
      ),
    );
  }

  // Handles saving the to-do list and displaying a success/failure message
  Future<void> _saveTodoList() async {
    if (todos.isNotEmpty && todos.values.first.trim().isNotEmpty) {
      TodoListModel todoListModel = TodoListModel(
          title: titleController.text, todolist: todos.values.toList());

      tripModel.todolist ??= [];
      tripModel.todolist?.add(todoListModel);

      await TripDb().editUser(tripModel.key, tripModel).then((_) {
        _showSnackBar(
          context,
          'Todo List saved successfully!',
          Icons.check_circle_outline,
          Colors.green.shade600,
        );
        Navigator.of(context).pop(tripModel);
      });
    } else {
      _showSnackBar(
        context,
        'Please write.....',
        Icons.not_interested_sharp,
        Colors.red,
      );
    }
  }

  // Utility function for showing SnackBars
  void _showSnackBar(
      BuildContext context, String message, IconData icon, Color iconColor) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ],
      ),
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20.0,
        ),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(
        30,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ScaffoldMessenger.of(context).showSnackBar(snackBar),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>(
          'titleController', titleController),
    );
  }
}
