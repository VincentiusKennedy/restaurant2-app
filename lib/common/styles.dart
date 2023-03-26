import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color.fromARGB(255, 240, 149, 240);
const Color secondaryColor = Color.fromARGB(255, 252, 119, 185);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.ubuntu(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.ubuntu(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.ubuntu(fontSize: 46, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.ubuntu(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.ubuntu(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.ubuntu(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.ubuntu(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.ubuntu(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.rajdhani(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.rajdhani(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.rajdhani(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.rajdhani(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.rajdhani(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
