import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';


const Color textPrimary = Color(0xFF111111);
const Color textSecondary = Color(0xFF3A3A3A);

TextStyle headlineTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 26,
        color: textPrimary,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w300));

TextStyle headlineSecondaryTextStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 20, color: textPrimary, fontWeight: FontWeight.w300));

TextStyle subtitleTextStyle = GoogleFonts.openSans(
    textStyle:
        const TextStyle(fontSize: 14, color: textSecondary, letterSpacing: 1));

TextStyle bodyTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(fontSize: 14, color: textPrimary));

TextStyle buttonTextStyle = GoogleFonts.montserrat(
    textStyle:
        const TextStyle(fontSize: 14, color: textPrimary, letterSpacing: 1));






// STANDART

// const Color textPrimary = Color(0xFF111111);
// const Color textSecondary = Color(0xFF3A3A3A);

// TextStyle headlineTextStyle = GoogleFonts.montserrat(
//     textStyle: const TextStyle(
//         fontSize: 26,
//         color: textPrimary,
//         letterSpacing: 1.5,
//         fontWeight: FontWeight.w300));

// TextStyle headlineSecondaryTextStyle = GoogleFonts.montserrat(
//     textStyle: const TextStyle(
//         fontSize: 20, color: textPrimary, fontWeight: FontWeight.w300));

// TextStyle subtitleTextStyle = GoogleFonts.openSans(
//     textStyle:
//         const TextStyle(fontSize: 14, color: textSecondary, letterSpacing: 1));

// TextStyle bodyTextStyle = GoogleFonts.openSans(
//     textStyle: const TextStyle(fontSize: 14, color: textPrimary));

// TextStyle buttonTextStyle = GoogleFonts.montserrat(
//     textStyle:
//         const TextStyle(fontSize: 14, color: textPrimary, letterSpacing: 1));
