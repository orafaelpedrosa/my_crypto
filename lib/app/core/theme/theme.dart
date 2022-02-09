import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primaryColor: const Color(0xff2C3333),
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
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: Color(0xffffffff),
      fontSize: 25,
    ),
    headline2: TextStyle(
      color: Color(0xffffffff),
      fontSize: 22,
    ),
    headline3: TextStyle(
      color: Color(0xffffffff),
      fontSize: 20,
    ),
    headline4: TextStyle(
      color: Color(0xffffffff),
      fontSize: 18,
    ),
    headline5: TextStyle(
      color: Color(0xffffffff),
      fontSize: 16,
    ),
    headline6: TextStyle(
      color: Color(0xffffffff),
      fontSize: 14,
    ),
  ),
);