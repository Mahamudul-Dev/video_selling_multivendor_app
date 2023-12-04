// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

final APP_THEME = ThemeData(
    useMaterial3: true,
    textTheme: text_theme,
    iconTheme: const IconThemeData(
      color: Colors.white, // Change this color to your desired color
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: SECONDARY_APP_COLOR,
        foregroundColor: Colors.white,
        titleTextStyle: text_theme.titleLarge?.copyWith(color: Colors.white)));

final text_theme = TextTheme(
    titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
    titleMedium: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 40),
    titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
    labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
    labelMedium: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 16),
    labelSmall: TextStyle(),
    bodyLarge: TextStyle(),
    bodyMedium:
        GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 14),
    bodySmall:
        GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 11));
