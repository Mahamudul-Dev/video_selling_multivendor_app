import 'package:get/get.dart';

import '../controllers/buyer_products_controller.dart';

class BuyerProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerProductsController>(
      () => BuyerProductsController(),
    );
  }
}
