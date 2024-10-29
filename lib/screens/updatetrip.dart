import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/database/trip.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/screens/planning.dart';
import 'package:travel_app/widgets/text._style.dart';

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
                child: CustomText(
                  text: 'Edit your trip',
                  fontsize: 20,
                  fontweight: FontWeight.w600,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Place',
                      fontsize: 18,
                      fontweight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.green.shade600,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Place cannot be empty';
                        }
                        return null;
                      },
                      controller: placecontroller,
                      decoration: InputDecoration(
                        hintText: 'Where to ?',
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Companion',
                      fontsize: 18,
                      fontweight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: Colors.green.shade600,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                      ),
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: 'Add your Companion',
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Budget',
                      fontsize: 18,
                      fontweight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      cursorColor: Colors.green.shade600,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                      ),
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
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        prefix: Text(
                          '₹',
                          style: GoogleFonts.lato(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Start Date',
                          fontsize: 18,
                          fontweight: FontWeight.w500,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        TextFormField(
                          cursorColor: Colors.green.shade600,
                          style: GoogleFonts.lato(
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Start date cannot be empty';
                            }
                            return null;
                          },
                          controller: startDateController,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.black,
                              ),
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
                                        DateFormat('dd-MM-yyyy')
                                            .format(picked.end);
                                  });
                                }
                              },
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.green.shade600,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.green.shade600,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'End Date',
                      fontsize: 18,
                      fontweight: FontWeight.w500,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                      cursorColor: Colors.green.shade600,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'End date cannot be empty';
                        }

                        return null;
                      },
                      controller: endDateController,
                      decoration: InputDecoration(
                        hintText: 'End Date',
                        hintStyle: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
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
                                      DateFormat('dd-MM-yyyy')
                                          .format(picked.end);
                                },
                              );
                            }
                          },
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green.shade600,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              )
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
