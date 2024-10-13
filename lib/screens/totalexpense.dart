import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/database/trip.dart';
import 'package:travel_app/datamodel/tripmodel.dart';

import '../datamodel/expensemodel.dart';

class TotalExpense extends StatefulWidget {
  final TripModel tripModel;
  const TotalExpense({super.key, required this.tripModel});

  @override
  State<TotalExpense> createState() => _TotalExpenseState();
}

class _TotalExpenseState extends State<TotalExpense> {
  TextEditingController foodcontroller = TextEditingController();
  TextEditingController travelfarecontroller = TextEditingController();
  TextEditingController clothescontroller = TextEditingController();
  TextEditingController staycontroller = TextEditingController();
  TextEditingController medicinecontroller = TextEditingController();
  TextEditingController othercontroller = TextEditingController();
  late TripModel tripModel;
  @override
  void initState() {
    tripModel = widget.tripModel;
    foodcontroller.text = tripModel.expense?.food ?? '';
    travelfarecontroller.text = tripModel.expense?.travelfare ?? '';
    clothescontroller.text = tripModel.expense?.clothes ?? '';
    staycontroller.text = tripModel.expense?.stay ?? '';
    medicinecontroller.text = tripModel.expense?.medicine ?? '';
    othercontroller.text = tripModel.expense?.other ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, tripModel);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Total Expenses',
          style: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              ExpenseModel expenseModel = ExpenseModel(
                food: foodcontroller.text,
                travelfare: travelfarecontroller.text,
                clothes: clothescontroller.text,
                stay: staycontroller.text,
                medicine: medicinecontroller.text,
                other: othercontroller.text,
              );

              tripModel.expense = expenseModel;
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
                            'Your expense  saved successfully!',
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
            },
            icon: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.food_bank,
                size: 50,
                color: Colors.green,
              ),
              title: Text(
                'Food',
                style: GoogleFonts.lato(
                  fontSize: 25,
                ),
              ),
              trailing: SizedBox(
                width: 90,
                child: TextFormField(
                  maxLength: 5,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: foodcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(1),
                    hintText: 'Expense',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 19,
                    ),
                    prefix: const Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.train,
                size: 50,
                color: Colors.orange,
              ),
              title: Text(
                'Travel Fare',
                style: GoogleFonts.lato(
                  fontSize: 25,
                ),
              ),
              trailing: SizedBox(
                width: 90,
                child: TextFormField(
                  maxLength: 5,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: travelfarecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(1),
                    hintText: 'Expense',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 19,
                    ),
                    prefix: const Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.hotel,
                size: 50,
                color: Colors.blue,
              ),
              title: Text(
                'Stay',
                style: GoogleFonts.lato(
                  fontSize: 25,
                ),
              ),
              trailing: SizedBox(
                width: 90,
                child: TextFormField(
                  maxLength: 5,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: staycontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(1),
                    hintText: 'Expense',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 19,
                    ),
                    prefix: const Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.mail_outline_rounded,
                size: 50,
                color: Colors.red,
              ),
              title: Text(
                'Clothes',
                style: GoogleFonts.lato(
                  fontSize: 25,
                ),
              ),
              trailing: SizedBox(
                width: 90,
                child: TextFormField(
                  maxLength: 5,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: clothescontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(1),
                    hintText: 'Expense',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 19,
                    ),
                    prefix: const Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.medical_services_rounded,
                size: 50,
                color: Colors.black,
              ),
              title: Text(
                'Medicine',
                style: GoogleFonts.lato(
                  fontSize: 25,
                ),
              ),
              trailing: SizedBox(
                width: 90,
                child: TextFormField(
                  maxLength: 5,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: medicinecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(1),
                    hintText: 'Expense',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 19,
                    ),
                    prefix: const Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.label_outline_sharp,
                size: 50,
                color: Colors.brown,
              ),
              title: Text(
                'Other',
                style: GoogleFonts.lato(
                  fontSize: 25,
                ),
              ),
              trailing: SizedBox(
                width: 90,
                child: TextFormField(
                  maxLength: 5,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: othercontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(1),
                    hintText: 'Expense',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 19,
                    ),
                    prefix: const Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
