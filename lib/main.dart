import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/utils/constants.dart';
import 'app/routes/app_pages.dart';
import 'themes/app_themes.dart';
import 'themes/theme_controller.dart';

 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  await GetStorage.init();
  await Firebase.initializeApp();

  final themeController = Get.put(ThemeController());

  runApp(
    Obx(() => GetMaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.getInitialRoute(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      getPages: AppPages.routes,
    ))
  );
}