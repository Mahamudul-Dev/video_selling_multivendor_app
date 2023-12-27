import 'package:get/get.dart';

import '../controllers/buyer_product_details_controller.dart';

class BuyerProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerProductDetailsController>(
      () => BuyerProductDetailsController(),
    );
  }
}
