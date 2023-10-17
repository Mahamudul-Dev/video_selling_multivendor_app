import 'package:get/get.dart';

import '../controllers/buyer_chat_controller.dart';

class BuyerChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerChatController>(
      () => BuyerChatController(),
    );
  }
}
