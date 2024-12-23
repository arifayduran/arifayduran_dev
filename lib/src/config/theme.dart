import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color textColorDark = white;
const Color textColorLight = mainGrey;

const Color effectColorDark = black;
const Color effectColorLight = mainBlue;
const Color destinationColorDark = darkBlue;
const Color destinationColorLight = white;

const Color touchColorDark = mainRed;
const Color touchColorLight = lightBlue;
const Color secondaryTouchColorDark = white;
const Color secondaryTouchColorLight = mainGrey;

Color snackBarColorDark = effectColorDark.withValues(alpha: 0.5);
Color snackBarColorLight = effectColorLight.withValues(alpha: 0.5);
Color snackBarTextColorDark = white;
Color snackBarTextColorLight = white;

const Color white = Colors.white;
const Color black = Colors.black;
const Color lightGrey = Colors.grey;
const Color mainGrey = Color(0xFF333132);
const Color darkGrey = Color(0xFF1E1E1E);
const Color mainRed = Color(0xFFD02A1E);
const Color lightBlue = Color.fromARGB(255, 105, 194, 235);
const Color darkBlue = Color(0xFF1B2D46);
const Color babyblue = Color.fromARGB(255, 39, 167, 181);
const Color mainBlue = Color(0xFF2D74AF);

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
    // surface: white,
    seedColor: lightGrey,
    primary: mainGrey,
    // secondary: mainGrey, // lightBlue -- basta boslukta cikiyor
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
    // surface: mainGrey,
    seedColor: white,
    primary: white,
    // secondary: black, // mainRed -- basta boslukta cikiyor
    brightness: Brightness.dark,
    // tertiary: black,
    // onError: mainRed,
  ),
);
