import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/seller/modules/seller_dashboard/controllers/seller_dashboard_controller.dart';

import '../../seller_inbox/controllers/seller_inbox_controller.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../controllers/seller_home_controller.dart';

class SellerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerHomeController>(
      () => SellerHomeController(),
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
