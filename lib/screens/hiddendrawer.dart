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
  // TextEditingController usercontroller = TextEditingController();
  // String profile = '';

  List<ScreenHiddenDrawer> _pages = [];
  ValueNotifier<String> selected = ValueNotifier('Journey');
  final myTextStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 17,
    fontStyle: FontStyle.italic,
  );
  final theTextStyle = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 30,
  );
  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'Journey',
            baseStyle: myTextStyle,
            selectedStyle: theTextStyle,
            colorLineSelected: Colors.green.shade600,
            onTap: () {
              selected.value = 'Journey';
            }),
        const Home(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'User',
            baseStyle: myTextStyle,
            selectedStyle: theTextStyle,
            colorLineSelected: Colors.green.shade600,
            onTap: () {
              selected.value = 'User';
            }),
        const UserDetails(),
      )
    ];
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
