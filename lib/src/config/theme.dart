import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color white = Colors.white;
const Color black = Colors.black;
const Color lightGrey = Colors.grey;
const Color mainGrey = Color(0xFF333132);
const Color darkGrey = Color(0xFF1E1E1E);
const Color mainRed = Color(0xFFD02A1E);
const Color lightBlue = Color.fromARGB(255, 105, 194, 235);
const Color mainBlue = Color.fromARGB(255, 45, 116, 175);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  textTheme: ThemeData.light()
      .textTheme
      .apply(fontFamily: GoogleFonts.roboto().fontFamily),
  appBarTheme: const AppBarTheme(
    color: white,
    surfaceTintColor: white,
    iconTheme: IconThemeData(color: mainGrey),
  ),
  colorScheme: ColorScheme.fromSeed(
    surface: lightGrey,
    seedColor: white,
    primary: mainGrey,
    secondary: lightBlue,
    brightness: Brightness.light,
    tertiary: Colors.black,
    onError: mainRed,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  textTheme: ThemeData.dark()
      .textTheme
      .apply(fontFamily: GoogleFonts.roboto().fontFamily),
  appBarTheme: const AppBarTheme(
    color: mainGrey,
    surfaceTintColor: mainGrey,
    iconTheme: IconThemeData(color: white),
  ),
  colorScheme: ColorScheme.fromSeed(
    surface: lightGrey,
    seedColor: mainGrey,
    primary: white,
    secondary: mainRed,
    brightness: Brightness.dark,
    tertiary: black,
    onError: mainRed,
  ),
);
