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
  TextEditingController foodController = TextEditingController();
  TextEditingController travelFareController = TextEditingController();
  TextEditingController clothesController = TextEditingController();
  TextEditingController stayController = TextEditingController();
  TextEditingController medicineController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  late TripModel tripModel;

  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;
    foodController.text = tripModel.expense?.food ?? '';
    travelFareController.text = tripModel.expense?.travelfare ?? '';
    clothesController.text = tripModel.expense?.clothes ?? '';
    stayController.text = tripModel.expense?.stay ?? '';
    medicineController.text = tripModel.expense?.medicine ?? '';
    otherController.text = tripModel.expense?.other ?? '';
  }

  int calculateTotalExpense() {
    return [
      int.tryParse(foodController.text) ?? 0,
      int.tryParse(travelFareController.text) ?? 0,
      int.tryParse(clothesController.text) ?? 0,
      int.tryParse(stayController.text) ?? 0,
      int.tryParse(medicineController.text) ?? 0,
      int.tryParse(otherController.text) ?? 0,
    ].reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              ExpenseModel expenseModel = ExpenseModel(
                food: foodController.text,
                travelfare: travelFareController.text,
                clothes: clothesController.text,
                stay: stayController.text,
                medicine: medicineController.text,
                other: otherController.text,
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
                            'Your expense has been saved successfully!',
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
                  // Navigator.of(context).pop(tripModel);
                },
              );
              calculateTotalExpense();
              setState(() {});
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _expenseInputCard(
                Icons.food_bank, 'Food', '₹', foodController, Colors.green),
            _expenseInputCard(
              Icons.train,
              'Travel Fare',
              '₹',
              travelFareController,
              Colors.orange,
            ),
            _expenseInputCard(
                Icons.hotel, 'Stay', '₹', stayController, Colors.blue),
            _expenseInputCard(
              Icons.mail_outline_rounded,
              'Clothes',
              '₹',
              clothesController,
              Colors.red,
            ),
            _expenseInputCard(
              Icons.medical_services_rounded,
              'Medicine',
              '₹',
              medicineController,
              Colors.black,
            ),
            _expenseInputCard(
              Icons.label_outline_sharp,
              'Other',
              '₹',
              otherController,
              Colors.brown,
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.green,
              thickness: 2,
            ),
            ListTile(
              title: Text(
                'Total Expense',
                style: GoogleFonts.lato(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                '₹ ${calculateTotalExpense()}',
                style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expenseInputCard(IconData icon, String label, String prefix,
      TextEditingController controller, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: ListTile(
          leading: Icon(
            icon,
            size: 40,
            color: color,
          ),
          title: Text(
            label,
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: SizedBox(
            width: 90,
            child: TextFormField(
              maxLength: 6,
              maxLines: 1,
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                hintText: 'Expense',
                counterText: '',
                prefix: Text(
                  prefix,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                  ),
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
          ),
        ),
      ),
    );
  }
}
