import 'package:get/get.dart';

import '../controllers/seller_notification_controller.dart';

class SellerNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerNotificationController>(
      () => SellerNotificationController(),
    );
  }
}
