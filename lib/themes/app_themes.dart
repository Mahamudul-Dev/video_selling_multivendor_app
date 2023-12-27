// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'app_colors.dart';

final lightTheme = ThemeData(
    useMaterial3: true,
    textTheme: text_theme,
    colorScheme: lightColorScheme);

final darkTheme = ThemeData(
    useMaterial3: true,
    textTheme: text_theme, colorScheme: darkColorScheme);



final text_theme = TextTheme(
    titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
    titleMedium: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 40),
    titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
    labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
    labelMedium: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 16),
    labelSmall: const TextStyle(),
    bodyLarge: const TextStyle(),
    bodyMedium:
        GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 14),
    bodySmall:
        GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 11));
