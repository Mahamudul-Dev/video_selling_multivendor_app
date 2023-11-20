import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/utils/constants.dart';
import 'app/routes/app_pages.dart';
import 'themes/app_colors.dart';
import 'themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: SECONDARY_APP_COLOR,
  ));

  await GetStorage.init();
  await Firebase.initializeApp();
  
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