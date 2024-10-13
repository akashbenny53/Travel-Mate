import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/screens/journal.dart';
import 'package:travel_app/screens/todolist.dart';
import 'package:travel_app/screens/totalexpense.dart';

class JourneySs extends StatefulWidget {
  final TripModel tripModel;
  const JourneySs({super.key, required this.tripModel});

  @override
  State<JourneySs> createState() => _JourneySsState();
}

class _JourneySsState extends State<JourneySs> {
  ValueNotifier visible = ValueNotifier(false);
  late TripModel tripModel;
  @override
  void initState() {
    tripModel = widget.tripModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 51, 168, 55),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, tripModel);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  widget.tripModel.place,
                  style: GoogleFonts.lato(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Stack(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: widget.tripModel.image == ''
                              ? const AssetImage(
                                  'assets/addtripbbl.jpeg',
                                ) as ImageProvider
                              : FileImage(
                                  File(
                                    widget.tripModel.image,
                                  ),
                                ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              visible.value = !visible.value;
                            },
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.black,
                              size: 33,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: visible,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            visible.value = !visible.value;
                          },
                          child: Visibility(
                            visible: value,
                            child: Container(
                              height: 500,
                              width: 510,
                              color: Colors.white70,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width * .01,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Place:',
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          widget.tripModel.place,
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Companion:',
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          widget.tripModel.name,
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Expense:₹',
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          widget.tripModel.budget,
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Start Date:',
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd-MM-yyyy').format(
                                              widget.tripModel.startdate!),
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'End Date:',
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd-MM-yyyy').format(
                                              widget.tripModel.enddate!),
                                          style: GoogleFonts.lato(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodoList(
                        trip: widget.tripModel,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/mod1_todo.jpg',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TotalExpense(
                        tripModel: widget.tripModel,
                      ),
                    ),
                  ).then(
                    (value) {
                      if (value != null) {
                        tripModel = value;
                      }
                    },
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/expensetracker2_profile.jpg',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Journal(
                        tripModel: widget.tripModel,
                      ),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/journal2_profile.jpg',
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
