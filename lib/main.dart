import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_selling_multivendor_app/app/data/preferences/local_preferences.dart';

import 'app/data/utils/constants.dart';
import 'app/routes/app_pages.dart';
import 'services/deeplink_service.dart';
import 'themes/app_themes.dart';

 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  Get.put(DeepLinkController());
  await GetStorage.init();
  await Firebase.initializeApp();

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context)=> const VideoSellingMultiVendorApp(),
  ));
}

class VideoSellingMultiVendorApp extends StatelessWidget {
  const VideoSellingMultiVendorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child){
        return GetMaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          initialRoute: AppPages.getInitialRoute(),
          theme: AppTheme(context).getLightTheme,
          darkTheme: AppTheme(context).getDarkTheme,
          themeMode: LocalPreferences.getThemeMode() ? ThemeMode.light : ThemeMode.dark,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
