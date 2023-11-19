import 'package:get/get.dart';

import '../controllers/seller_inbox_controller.dart';

class SellerInboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerInboxController>(
      () => SellerInboxController(),
    );
  }
}
