import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/modules/buyer/purchase_list/controllers/purchase_list_controller.dart';
import '../../../../../themes/theme_controller.dart';
import '../../../global/inbox/controllers/inbox_controller.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../../buyer_dashboard/controllers/buyer_dashboard_controller.dart';
import '../../buyer_profile/controllers/buyer_profile_controller.dart';
import '../controllers/buyer_home_controller.dart';

class HomeBindingBuyer extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeControllerBuyer>(
      () => HomeControllerBuyer(),
    );

    Get.lazyPut<BuyerDashboardController>(
      () => BuyerDashboardController(),
    );

    Get.lazyPut<InboxController>(
      () => InboxController(),
    );

    Get.lazyPut<PurchaseListController>(
          () => PurchaseListController(),
    );

    Get.lazyPut<BuyerProfileController>(
      () => BuyerProfileController(),
    );

    Get.lazyPut<BuyerCartController>(
      () => BuyerCartController(),
    );

    Get.lazyPut<ThemeController>(
          () => ThemeController(),
    );
  }
}
