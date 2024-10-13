import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/datamodel/journalmodel.dart';
import 'package:travel_app/datamodel/tripmodel.dart';

class CreateJournal extends StatefulWidget {
  final TripModel tripModel;

  const CreateJournal({super.key, required this.tripModel});

  @override
  State<CreateJournal> createState() => _CreateJournalState();
}

class _CreateJournalState extends State<CreateJournal> {
  final TextEditingController _contentcontroller = TextEditingController();

  Future<void> _saveJournalEntry() async {
    String content = _contentcontroller.text.trim();

    if (content.isEmpty) {
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            // ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.not_interested_sharp,
                    color: Colors.red,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'Please write.....',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(30),
            ),
          );
        },
      );
      return;
    }
    try {
      var journalBox = Hive.box<JournalModel>('journalBox');

      JournalModel newJournal = JournalModel(content: content);

      int journalKey = await journalBox.add(newJournal);

      widget.tripModel.journalKeys ??= [];
      widget.tripModel.journalKeys!.add(journalKey);

      await widget.tripModel.save();

      if (!mounted) return;

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
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
                      'Journal saved successfully!',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(30),
            ),
          );
        },
      );

      Navigator.of(context).pop(widget.tripModel);
    } catch (e) {
      if (!mounted) return;

      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.not_interested_sharp,
                    color: Colors.red,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'Failed to save journal: $e',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(30),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, d MMMM ').format(now);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text(
          formattedDate,
          style: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Save',
            onPressed: _saveJournalEntry,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _contentcontroller,
                    autofocus: true,
                    minLines: 3,
                    maxLines: 40,
                    decoration: InputDecoration(
                      hintText: 'Start writing...',
                      hintStyle: GoogleFonts.lato(
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
