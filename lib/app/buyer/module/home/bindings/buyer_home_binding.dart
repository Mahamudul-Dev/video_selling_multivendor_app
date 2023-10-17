import 'package:get/get.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../../buyer_chat/controllers/buyer_chat_controller.dart';
import '../../buyer_dashboard/controllers/buyer_dashboard_controller.dart';
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

    Get.lazyPut<BuyerChatController>(
      () => BuyerChatController(),
    );

    Get.lazyPut<BuyerCartController>(
      () => BuyerCartController(),
    );
  }
}
