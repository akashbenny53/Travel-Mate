import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/database/trip.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/screens/planning.dart';

class UpdateTrip extends StatefulWidget {
  final TripModel edittripmodel;
  const UpdateTrip({super.key, required this.edittripmodel});

  @override
  State<UpdateTrip> createState() => _UpdateTripState();
}

class _UpdateTripState extends State<UpdateTrip> {
  late TripModel edittripmodel;
  String image = '';
  TextEditingController namecontroller = TextEditingController();
  TextEditingController placecontroller = TextEditingController();
  TextEditingController budgetcontroller = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late DateTimeRange dateTimeRange;

  @override
  void initState() {
    super.initState();

    edittripmodel = widget.edittripmodel;
    dateTimeRange = DateTimeRange(
      start: edittripmodel.startdate ?? DateTime.now(),
      end: edittripmodel.enddate ?? DateTime.now(),
    );
    image = edittripmodel.image;
    log(edittripmodel.name);
    const JourneyPlan();
    namecontroller = TextEditingController(
      text: edittripmodel.name,
    );
    // ignore: unused_local_variable
    placecontroller = TextEditingController(
      text: edittripmodel.place,
    );
    // ignore: unused_local_variable
    budgetcontroller = TextEditingController(
      text: edittripmodel.budget,
    );

    startDateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(
        edittripmodel.startdate ?? DateTime.now(),
      ),
    );
    // ignore: unused_local_variable
    endDateController = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(
        edittripmodel.enddate ?? DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).height * .02,
                ),
                child: const Text(
                  'Edit your trip',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
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
              const SizedBox(
                height: 30,
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
                        borderSide: BorderSide.none),
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
                    prefix: const Text('₹'),
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
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Start date cannot be empty';
                        }
                        return null;
                      },
                      controller: startDateController,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.calendar_month_outlined),
                          color: Colors.black,
                          onPressed: () async {
                            final DateTimeRange? picked =
                                await showDateRangePicker(
                              context: context,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2025),
                            );
                            if (picked != null) {
                              setState(() {
                                startDateController.text =
                                    DateFormat('dd-MM-yyyy')
                                        .format(picked.start);
                                endDateController.text =
                                    DateFormat('dd-MM-yyyy').format(picked.end);
                              });
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
                  ],
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
              TextButton(
                onPressed: () async {
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
                            'Trip edited successfully!',
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
                  if (!formkey.currentState!.validate()) {
                  } else {
                    edittripmodel.budget = budgetcontroller.text;
                    edittripmodel.image = image;
                    edittripmodel.name = namecontroller.text;
                    edittripmodel.place = placecontroller.text;
                    edittripmodel.startdate = dateTimeRange.start;
                    edittripmodel.enddate = dateTimeRange.end;
                    await TripDb()
                        .editUser(
                          edittripmodel.key,
                          edittripmodel,
                        )
                        .then(
                          (value) => Navigator.of(context).pop(),
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
                  'Save',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
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
