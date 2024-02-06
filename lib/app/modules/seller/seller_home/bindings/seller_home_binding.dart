import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/themes/theme_controller.dart';
import '../controllers/seller_home_controller.dart';

class SellerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerHomeController>(
      () => SellerHomeController(),
    );

    Get.lazyPut<ThemeController>(
          () => ThemeController(),
    );
    //
    // Get.lazyPut<SellerDashboardController>(
    //       () => SellerDashboardController(),
    // );
    // Get.lazyPut<WalletController>(
    //       () => WalletController(),
    // );
    // Get.lazyPut<SellerInboxController>(
    //       () => SellerInboxController(),
    // );
  }
}
