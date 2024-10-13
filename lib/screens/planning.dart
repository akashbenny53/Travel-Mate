import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/database/trip.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/screens/hiddendrawer.dart';

class JourneyPlan extends StatefulWidget {
  const JourneyPlan({super.key});

  @override
  State<JourneyPlan> createState() => _JourneyPlanState();
}

class _JourneyPlanState extends State<JourneyPlan> {
  String image = '';
  TextEditingController namecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController budgetcontroller = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  DateTimeRange dateTimeRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  @override
  void initState() {
    super.initState();
    // Initialize start date with today's date
    startDateController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.sizeOf(context).height * .02,
                  ),
                  child: const Center(
                    child: Text(
                      'Planning of a new journey',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Create a comprehensive itinerary and chart your forthcoming travel arrangements.',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await getimage().then(
                        (value) {
                          if (value != null) {
                            setState(
                              () {
                                image = value.path;
                              },
                            );
                          }
                        },
                      );
                    },
                    child: image == ''
                        ? const CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              'assets/addtripbbl.jpeg',
                            ),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(
                              File(image),
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place cannot be empty';
                      }
                      return null;
                    },
                    controller: placecontroller,
                    decoration: InputDecoration(
                      hintText: 'Where to ?',
                      hintStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.green.shade600,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: 'Add your Companion',
                      hintStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.green.shade600,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Budget cannot be empty';
                      }
                      return null;
                    },
                    controller: budgetcontroller,
                    decoration: InputDecoration(
                      hintText: 'Budget',
                      hintStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      prefix: const Text('₹'),
                      fillColor: Colors.green.shade600,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Start date cannot be empty';
                      }
                      return null;
                    },
                    controller: startDateController,
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.black,
                        ),
                        onTap: () async {
                          final DateTimeRange? picked =
                              await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2023),
                            lastDate: DateTime(2025),
                          );
                          if (picked != null) {
                            dateTimeRange = picked;
                            setState(
                              () {
                                startDateController.text =
                                    DateFormat('dd-MM-yyyy')
                                        .format(picked.start);
                                endDateController.text =
                                    DateFormat('dd-MM-yyyy').format(picked.end);
                              },
                            );
                          }
                        },
                      ),
                      filled: true,
                      fillColor: Colors.green.shade600,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'end date cannot be empty';
                      }

                      return null;
                    },
                    controller: endDateController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.black,
                      ),
                      filled: true,
                      fillColor: Colors.green.shade600,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      if (!formkey.currentState!.validate()) {
                      } else {
                        await setsharedpreference();
                        await TripDb()
                            .addUser(
                          TripModel(
                            budget: budgetcontroller.text,
                            image: image,
                            name: namecontroller.text,
                            place: placecontroller.text,
                            startdate: dateTimeRange.start,
                            enddate: dateTimeRange.end,
                          ),
                        )
                            .then(
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
                                  const Expanded(
                                    child: Text(
                                      'Trip saved successfully!',
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
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackbar);
                            });
                            Navigator.of(context).pushAndRemoveUntil<void>(
                              MaterialPageRoute<void>(
                                builder: (context) => const HiddenDrawer(),
                              ),
                              (route) => false,
                            );
                          },
                        );
                      }
                    },
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll<Size>(
                        Size(100, 40),
                      ),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.black),
                      foregroundColor:
                          MaterialStatePropertyAll<Color>(Colors.white),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<XFile?> getimage() async {
    ImagePicker imagePicker = ImagePicker();
    return await imagePicker.pickImage(source: ImageSource.gallery);
  }

  Future setsharedpreference() async {
    final preference = await SharedPreferences.getInstance();
    preference.setString("My Value", 'true');
  }
}
