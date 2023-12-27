import 'package:get/get.dart';
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

    Get.lazyPut<BuyerProfileController>(
      () => BuyerProfileController(),
    );

    Get.lazyPut<BuyerCartController>(
      () => BuyerCartController(),
    );
  }
}
