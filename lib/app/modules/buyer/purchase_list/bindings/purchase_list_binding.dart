import 'package:get/get.dart';

import '../controllers/purchase_list_controller.dart';

class PurchaseListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseListController>(
      () => PurchaseListController(),
    );
  }
}
