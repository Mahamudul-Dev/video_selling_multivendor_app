import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/preferences/local_preferences.dart';
import 'package:video_selling_multivendor_app/themes/app_themes.dart';

class ThemeController extends GetxController {
  
  RxBool isDarkMode = true.obs;

  @override
  void onInit() {
    isDarkMode.value = LocalPreferences.getThemeMode();
    super.onInit();
  }

    void toggleTheme() {
    isDarkMode.toggle();
    Get.changeTheme(
      isDarkMode.value
          ? darkTheme
          : lightTheme,
    );

    LocalPreferences.saveThemeMode(isDarkMode.value);
  }
}