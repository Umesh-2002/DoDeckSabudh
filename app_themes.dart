// lib/themes/app_themes.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

 final Light_Theme_Show = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey[100],
  primarySwatch: Colors.deepPurple,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.deepPurple,
    onPrimary: Colors.white,
    secondary: Colors.deepPurpleAccent,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black87,
    surfaceVariant: Colors.yellow[100],
    onSurfaceVariant: Colors.black87,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
  ),
  cardColor: Colors.white,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.oswald(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
    titleMedium: GoogleFonts.montserrat(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
    bodyMedium:
    GoogleFonts.roboto(fontSize: 16, color: Colors.black87),
    bodySmall:
    GoogleFonts.openSans(fontSize: 14, color: Colors.black54),
  ),
);

final Dark_Theme_Show =  ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.blueGrey[900]!,
  primarySwatch: Colors.indigo,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.indigo,
    onPrimary: Colors.white,
    secondary: Colors.indigoAccent,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.black,
    background: Colors.blueGrey[900],
    onBackground: Colors.white,
    surface: Colors.indigo[700]!,
    onSurface: Colors.white,
    surfaceVariant: Colors.indigo[600],
    onSurfaceVariant: Colors.white70,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.tealAccent.shade700,
    foregroundColor: Colors.black,
  ),
  cardColor: Colors.indigo[700]!,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.oswald(
        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: GoogleFonts.montserrat(
        fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
    bodyMedium: GoogleFonts.roboto(
        fontSize: 16, color: Colors.white),
    bodySmall: GoogleFonts.openSans(
        fontSize: 14, color: Colors.white70),
  ),
);
