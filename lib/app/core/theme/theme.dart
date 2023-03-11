import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme = ThemeData(
  primaryColor: const Color(0xff5865F2),
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: const Color(0xff1a1a1a),
  cardColor: Color(0xFF455A64),
  brightness: Brightness.dark,
  dividerTheme: const DividerThemeData(
    color: Colors.white,
  ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xFF5865F2),
    selectionColor: const Color(0xFF5865F2).withOpacity(0.5),
    selectionHandleColor: const Color(0xFF5865F2),
  ),
  iconTheme: const IconThemeData(
    color: Color(0xff5865F2),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xff5865F2),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: GoogleFonts.workSans().fontFamily,
      color: Color(0xff5865F2),
      fontSize: 25,
    ),
    displayMedium: TextStyle(
      fontFamily: GoogleFonts.workSans().fontFamily,
      color: Color(0xff5865F2),
      fontSize: 22,
    ),
    displaySmall: TextStyle(
      fontFamily: GoogleFonts.workSans().fontFamily,
      color: Color(0xff5865F2),
      fontSize: 20,
    ),
    headlineMedium: TextStyle(
      fontFamily: GoogleFonts.workSans().fontFamily,
      color: Color(0xff5865F2),
      fontSize: 18,
    ),
    headlineSmall: TextStyle(
      fontFamily: GoogleFonts.workSans().fontFamily,
      color: Color(0xff5865F2),
      fontSize: 16,
      height: 1.5,
    ),
    titleLarge: TextStyle(
      fontFamily: GoogleFonts.workSans().fontFamily,
      color: Color(0xff5865F2),
      fontSize: 14,
      height: 1.5,
    ),
  ),
  colorScheme: ColorScheme(
    // background: const Color(0xff050409),
    background: const Color(0xff0D0B18),

    brightness: Brightness.dark,
    error: Colors.red,
    onError: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    primary: const Color(0xff5865F2),
    secondary: Colors.white,
    tertiary: Color(0xff858585),
    surface: Colors.white,
    onBackground: Color(0xff201F26),
  ),
);
