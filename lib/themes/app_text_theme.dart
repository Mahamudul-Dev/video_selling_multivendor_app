part of 'app_themes.dart';

class AppTextTheme{
  BuildContext context;
  AppTextTheme(this.context);
  get getTextTheme => TextTheme(
      titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: context.textScaleFactor * 20),
      titleMedium: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: context.textScaleFactor * 40),
      titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: context.textScaleFactor * 14),
      labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: context.textScaleFactor * 16),
      labelMedium: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: context.textScaleFactor * 16),
      labelSmall: const TextStyle(),
      bodyLarge: const TextStyle(),
      bodyMedium:
      GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: context.textScaleFactor * 14),
      bodySmall:
      GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: context.textScaleFactor * 11));
}