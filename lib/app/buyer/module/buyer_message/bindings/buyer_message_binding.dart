import 'package:get/get.dart';

import '../controllers/buyer_message_controller.dart';

class BuyerMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerMessageController>(
      () => BuyerMessageController(),
    );
  }
}
