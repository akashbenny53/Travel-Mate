import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/database/trip.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/screens/hiddendrawer.dart';
import 'package:travel_app/widgets/text._style.dart';

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
                  child: Center(
                    child: CustomText(
                      text: 'Planning of a new journey',
                      fontsize: 28,
                      fontweight: FontWeight.w500,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomText(
                      text:
                          'Create a comprehensive itinerary and chart your forthcoming travel arrangements.',
                      fontsize: 16,
                      fontweight: FontWeight.w400,
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
