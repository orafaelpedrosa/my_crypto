import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData(
  primaryColor: const Color(0xff216BFD),
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: const Color(0xff1a1a1a),
  backgroundColor: const Color(0xff1a1a1a),
  cardColor: Colors.grey,
  brightness: Brightness.dark,
  dividerTheme: const DividerThemeData(
    color: Colors.white,
  ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xFF2666cf),
    selectionColor: const Color(0xFF2666cf).withOpacity(0.5),
    selectionHandleColor: const Color(0xFF2666cf),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xff2666cf),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xff2666cf),
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      color: Color(0xff216BFD),
      fontSize: 25,
    ),
    headline2: TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      color: Color(0xff216BFD),
      fontSize: 22,
    ),
    headline3: TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      color: Color(0xff216BFD),
      fontSize: 20,
    ),
    headline4: TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      color: Color(0xff216BFD),
      fontSize: 18,
    ),
    headline5: TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      color: Color(0xff216BFD),
      fontSize: 16,
      height: 1.5,
    ),
    headline6: TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      color: Color(0xff216BFD),
      fontSize: 14,
      height: 1.5,
    ),
  ),
);
