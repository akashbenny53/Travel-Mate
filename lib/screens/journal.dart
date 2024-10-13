import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  @override
  void initState() {
    tripModel = widget.tripModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var journalBox = Hive.box<JournalModel>('journalBox');

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
      body: (tripModel.journalKeys == null || tripModel.journalKeys!.isEmpty)
          ? Center(
              child: Text(
                'No journals yet',
                style: GoogleFonts.lato(
                  fontSize: 20,
                ),
              ),
            )
          : ListView.builder(
              itemCount: tripModel.journalKeys!.length,
              itemBuilder: (context, index) {
                int journalKey = tripModel.journalKeys![index];
                JournalModel? journal = journalBox.get(journalKey);
                if (journal == null) return const SizedBox.shrink();

                return Slidable(
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                'Are you sure that you want to delete this journal ?',
                                style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.lato(
                                        color: Colors.green.shade600,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      var journalBox =
                                          Hive.box<JournalModel>('journalBox');
                                      await journalBox.delete(journalKey);
                                      // ignore: list_remove_unrelated_type
                                      tripModel.journalKeys?.remove(journalKey);
                                      TripDb cd = TripDb();
                                      await cd
                                          .editUser(tripModel.key, tripModel)
                                          .then(
                                        (value) {
                                          Navigator.of(context).pop();
                                        },
                                      );
                                      // ignore: empty_catches
                                    } catch (e) {}
                                    setState(() {});
                                  },
                                  child: Text(
                                    'Yes',
                                    style: GoogleFonts.lato(
                                        color: Colors.green.shade600,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        backgroundColor: Colors.white24,
                        foregroundColor: Colors.black,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Card(
                    color: Colors.green.shade600,
                    margin: const EdgeInsets.all(13),
                    child: ListTile(
                      title: Text(
                        journal.content,
                        style: const TextStyle(color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewJournal(
                              tripModel: tripModel,
                              journalModel: journal,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
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
        onPressed: () async {
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
        },
        icon: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
