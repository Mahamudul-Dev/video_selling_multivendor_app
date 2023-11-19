import 'package:get/get.dart';

import 'module/buyer_cart/controllers/buyer_cart_controller.dart';

Future<void> injectAllResources() async {
  await Get.find<BuyerCartController>().getAllCartItems();
}
