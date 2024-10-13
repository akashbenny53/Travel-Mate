import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/datamodel/journalmodel.dart';
import 'package:travel_app/datamodel/tripmodel.dart';

class ViewJournal extends StatelessWidget {
  final JournalModel journalModel;
  final TripModel tripModel;

  const ViewJournal(
      {super.key, required this.journalModel, required this.tripModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text(
          'Journal',
          style: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          journalModel.content,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
