import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  String text;
  double fontsize;
  FontWeight? fontweight;
  Color? color;

  CustomText(
      {super.key,
      required this.text,
      required this.fontsize,
      this.color,
      this.fontweight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: fontsize,
        fontWeight: fontweight,
        color: color,
      ),
    );
  }
}
