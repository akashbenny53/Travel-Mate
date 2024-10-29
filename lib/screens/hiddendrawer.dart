// ignore_for_file: duplicate_import
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:travel_app/screens/home.dart';
import 'package:travel_app/screens/userdetails.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  late List<ScreenHiddenDrawer> _pages;
  final ValueNotifier<String> selected = ValueNotifier('Journey');

  final TextStyle myTextStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 17,
    fontStyle: FontStyle.italic,
  );
  final TextStyle theTextStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 30,
    fontStyle: FontStyle.normal,
  );

  @override
  void initState() {
    super.initState();
    _initializePages();
  }

  void _initializePages() {
    _pages = [
      _buildScreenHiddenDrawer(
        name: 'Journey',
        page: const Home(),
      ),
      _buildScreenHiddenDrawer(
        name: 'User',
        page: const UserDetails(),
      ),
    ];
  }

  ScreenHiddenDrawer _buildScreenHiddenDrawer(
      {required String name, required Widget page}) {
    return ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: name,
        baseStyle: myTextStyle,
        selectedStyle: theTextStyle,
        colorLineSelected: Colors.green.shade600,
        onTap: () => selected.value = name,
      ),
      page,
    );
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorAppBar: const Color.fromARGB(255, 51, 168, 55),
      backgroundColorMenu: Colors.white,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 40,
      contentCornerRadius: 70,
      boxShadow: const [],
    );
  }
}
