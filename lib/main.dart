import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/constants/utils.dart';
import 'app/routes/app_pages.dart';
import 'themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:
        Colors.transparent, // Sets the navigation bar color to transparent
  ));

  await GetStorage.init();
  runApp(
    GetMaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.getInitialRoute(),
      theme: APP_THEME,
      getPages: AppPages.routes,
    ),
  );
}