import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'themes/app_themes.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "MyCellVids",
      initialRoute: AppPages.INITIAL,
      theme: APP_THEME,
      getPages: AppPages.routes,
    ),
  );
}
