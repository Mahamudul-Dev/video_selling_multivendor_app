// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

part 'app_colors.dart';
part 'app_text_theme.dart';

class AppTheme {
  final BuildContext context;
  AppTheme(this.context);



  get getLightTheme => ThemeData(
      useMaterial3: true,
      textTheme: AppTextTheme(context).getTextTheme,
      colorScheme: lightColorScheme);

  get getDarkTheme => ThemeData(
      useMaterial3: true,
      textTheme: AppTextTheme(context).getTextTheme, colorScheme: darkColorScheme);
}