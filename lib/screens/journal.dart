import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/database/trip.dart';
import 'package:travel_app/datamodel/journalmodel.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:travel_app/screens/createjournal.dart';
import 'package:travel_app/screens/viewjournal.dart';

class Journal extends StatefulWidget {
  final TripModel tripModel;
  const Journal({super.key, required this.tripModel});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  late TripModel tripModel;
  late final Box<JournalModel> journalBox;

  @override
  void initState() {
    super.initState();
    tripModel = widget.tripModel;
    journalBox = Hive.box<JournalModel>('journalBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildJournalList(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.green.shade600,
      title: Text(
        'Journal',
        style: GoogleFonts.lato(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildJournalList() {
    return tripModel.journalKeys == null || tripModel.journalKeys!.isEmpty
        ? _buildEmptyJournalMessage()
        : ListView.builder(
            itemCount: tripModel.journalKeys!.length,
            itemBuilder: (context, index) {
              int journalKey = tripModel.journalKeys![index];
              JournalModel? journal = journalBox.get(journalKey);
              return journal == null
                  ? const SizedBox.shrink()
                  : _buildJournalListItem(journal, journalKey);
            },
          );
  }

  Center _buildEmptyJournalMessage() {
    return Center(
      child: Text(
        'No journals yet',
        style: GoogleFonts.lato(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildJournalListItem(JournalModel journal, int journalKey) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _showDeleteConfirmationDialog(journalKey),
            backgroundColor: Colors.white24,
            foregroundColor: Colors.black,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        elevation: 4,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(20),
          leading: Icon(
            Icons.book_rounded,
            color: Colors.green.shade600,
            size: 40,
          ),
          title: Text(
            DateFormat('EEE, d MMMM').format(journal.date),
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            journal.content.length > 50
                ? '${journal.content.substring(0, 50)}...'
                : journal.content,
            style: GoogleFonts.lato(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          onTap: () => _navigateToViewJournal(journal),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(int journalKey) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'Are you sure you want to delete this journal?',
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.lato(
                color: Colors.green.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await _deleteJournal(journalKey);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
            child: Text(
              'Yes',
              style: GoogleFonts.lato(
                color: Colors.green.shade600,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteJournal(int journalKey) async {
    try {
      await journalBox.delete(journalKey);
      tripModel.journalKeys?.remove(journalKey);
      await TripDb().editUser(tripModel.key, tripModel);
      setState(() {});
    } catch (e) {
      // Handle deletion error if necessary
    }
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      label: Text(
        'Add new journal',
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      backgroundColor: Colors.green.shade600,
      onPressed: _navigateToCreateJournal,
      icon: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }

  Future<void> _navigateToCreateJournal() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateJournal(tripModel: tripModel),
      ),
    );
    if (result != null && result is TripModel) {
      setState(() {
        tripModel = result;
      });
    }
  }

  void _navigateToViewJournal(JournalModel journal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewJournal(
          tripModel: tripModel,
          journalModel: journal,
        ),
      ),
    );
  }
}
