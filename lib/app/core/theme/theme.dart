import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycrypto/app/core/theme/colors.dart';

ThemeData theme = ThemeData(
  primaryColor: const Color(0xff10002B),
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
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: AppColors.primaryColor,
      fontSize: 25,
    ),
    headline2: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: const Color(0xffffffff),
      fontSize: 22,
    ),
    headline3: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: const Color(0xffffffff),
      fontSize: 20,
    ),
    headline4: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: const Color(0xffffffff),
      fontSize: 18,
    ),
    headline5: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: const Color(0xffffffff),
      fontSize: 16,
    ),
    headline6: TextStyle(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      color: const Color(0xffffffff),
      fontSize: 14,
    ),
  ),
);
