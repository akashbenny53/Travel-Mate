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
  ValueNotifier<bool> isInfoVisible = ValueNotifier(false);
  late TripModel tripModel;

  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF33A837),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, tripModel);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            "Your Journey",
            style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.tripModel.place,
                  style: GoogleFonts.lato(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTripImageSection(),
              const SizedBox(height: 20),
              _buildActionCard(
                label: 'To-Do List',
                image: 'assets/new_todo_image.jpg',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodoList(trip: widget.tripModel),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildActionCard(
                label: 'Expense Tracker',
                image: 'assets/new_expense_image.jpg',
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TotalExpense(
                        tripModel: widget.tripModel,
                      ),
                    ),
                  );
                  if (result != null) {
                    setState(() {
                      tripModel = result;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              _buildActionCard(
                label: 'Journal',
                image: 'assets/new_journal_image.jpg',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Journal(tripModel: widget.tripModel),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripImageSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: widget.tripModel.image.isEmpty
                    ? const AssetImage('assets/trip-non.jpg')
                    : FileImage(File(widget.tripModel.image)) as ImageProvider,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: IconButton(
              onPressed: () {
                isInfoVisible.value = !isInfoVisible.value;
              },
              icon: const Icon(
                Icons.info_outline,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          _buildTripInfoOverlay(),
        ],
      ),
    );
  }

  Widget _buildTripInfoOverlay() {
    return ValueListenableBuilder(
      valueListenable: isInfoVisible,
      builder: (context, value, child) {
        return Visibility(
          visible: value,
          child: Positioned.fill(
            child: GestureDetector(
              onTap: () {
                isInfoVisible.value = false;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.place,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Place:',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            tripModel.place,
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1, height: 30),
                    Row(
                      children: [
                        const Icon(Icons.group, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Companion:',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          tripModel.name,
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1, height: 30),
                    Row(
                      children: [
                        const Icon(Icons.money, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Expense: ₹',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          tripModel.budget.toString(),
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1, height: 30),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Start Date:',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('dd-MM-yyyy').format(tripModel.startdate!),
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1, height: 30),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'End Date:',
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('dd-MM-yyyy').format(tripModel.enddate!),
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            color: Colors.white70,
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
    );
  }

  Widget _buildActionCard(
      {required String label,
      required String image,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
