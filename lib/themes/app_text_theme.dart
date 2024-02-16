part of 'app_themes.dart';

class AppTextTheme{
  BuildContext context;
  AppTextTheme(this.context);
  get getTextTheme => TextTheme(
      titleLarge: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20.sp),
      titleMedium: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 40.sp),
      titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14.sp),
      labelLarge: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16.sp),
      labelMedium: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 16.sp),
      labelSmall: GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 14.sp),
      bodyLarge: GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 16.sp),
      bodyMedium:
      GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 14.sp),
      bodySmall:
      GoogleFonts.poppins(fontWeight: FontWeight.normal, fontSize: 11.sp));
}