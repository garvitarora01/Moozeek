import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTabs extends StatelessWidget {
  final Color color;
  final String text;
  AppTabs(this.color, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      height: 50,
      child: Text(
        text,
        style: GoogleFonts.openSans(
            color: Color(0xFFF7F9F9),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 7,
              offset: Offset(0, 0),
            )
          ]),
    );
  }
}
