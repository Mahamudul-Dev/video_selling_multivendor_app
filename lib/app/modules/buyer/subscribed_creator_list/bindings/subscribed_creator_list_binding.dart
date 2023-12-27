import 'package:get/get.dart';

import '../controllers/subscribed_creator_list_controller.dart';

class SubscribedCreatorListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscribedCreatorListController>(
      () => SubscribedCreatorListController(),
    );
  }
}
