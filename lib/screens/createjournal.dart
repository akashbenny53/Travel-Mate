import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/datamodel/journalmodel.dart';
import 'package:travel_app/datamodel/tripmodel.dart';
import 'package:image_picker/image_picker.dart';

class CreateJournal extends StatefulWidget {
  final TripModel tripModel;

  const CreateJournal({super.key, required this.tripModel});

  @override
  State<CreateJournal> createState() => _CreateJournalState();
}

class _CreateJournalState extends State<CreateJournal> {
  // Controllers
  final TextEditingController _contentController = TextEditingController();

  // State variables
  DateTime selectedDate = DateTime.now();
  final List<File> _selectedImages = [];

  // --- Helper Functions --- //

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      setState(() {
        _selectedImages
            .addAll(images.map((image) => File(image.path)).toList());
      });
    }
  }

  Future<void> _saveJournalEntry() async {
    String content = _contentController.text.trim();
    if (content.isEmpty) {
      _showSnackBar('Please write...', Colors.red);
      return;
    }
    try {
      var journalBox = Hive.box<JournalModel>('journalBox');
      JournalModel newJournal = JournalModel(
        content: content,
        imagePaths: _selectedImages.map((img) => img.path).toList(),
        date: selectedDate,
      );

      int journalKey = await journalBox.add(newJournal);
      widget.tripModel.journalKeys ??= [];
      widget.tripModel.journalKeys!.add(journalKey);
      await widget.tripModel.save();

      _showSnackBar(
        'Journal saved successfully!',
        Colors.green,
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop(widget.tripModel);
    } catch (e) {
      _showSnackBar(
        'Failed to save journal: $e',
        Colors.red,
      );
    }
  }

  void _showSnackBar(String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.info,
                color: color,
                size: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  message,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  // --- Build UI Elements --- //

  Widget _buildDateSelector() {
    String formattedDate = DateFormat('EEE, d MMMM').format(selectedDate);
    return InkWell(
      onTap: () => _selectDate(context),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_today,
            size: 18,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            formattedDate,
            style: GoogleFonts.lato(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _selectedImages.map((image) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  image,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImages.remove(image);
                  });
                },
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.red.withOpacity(0.9),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildContentTextField() {
    return TextField(
      cursorColor: Colors.green.shade600,
      textCapitalization: TextCapitalization.sentences,
      controller: _contentController,
      autofocus: true,
      minLines: 3,
      maxLines: 40,
      decoration: InputDecoration(
        hintText: 'Start writing...',
        hintStyle: GoogleFonts.lato(fontSize: 20, color: Colors.black),
        border: InputBorder.none,
      ),
    );
  }

  // --- Build Scaffold --- //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade600,
        title: _buildDateSelector(),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black),
            tooltip: 'Save',
            onPressed: _saveJournalEntry,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if (_selectedImages.isNotEmpty) _buildImageGrid(),
              const SizedBox(height: 20),
              _buildContentTextField(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        onPressed: _pickImages,
        backgroundColor: Colors.green.shade600,
        tooltip: 'Pick Images',
        child: const Icon(
          Icons.photo_library_outlined,
          color: Colors.black,
        ),
      ),
    );
  }
}
