import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/data/preferences/local_preferences.dart';
import 'package:video_selling_multivendor_app/themes/app_themes.dart';

class ThemeController extends GetxController {
  
  RxBool isLightMode = false.obs;

  @override
  void onInit() {
    isLightMode.value = LocalPreferences.getThemeMode();
    super.onInit();
  }

    void toggleTheme() {
    isLightMode.toggle();
    Get.changeTheme(
      isLightMode.value
          ? AppTheme(Get.context!).getLightTheme
          : AppTheme(Get.context!).getDarkTheme,
    );
    LocalPreferences.saveThemeMode(isLightMode.value);
    print({
      "Theme Changed To": LocalPreferences.getThemeMode()
    });
  }
}