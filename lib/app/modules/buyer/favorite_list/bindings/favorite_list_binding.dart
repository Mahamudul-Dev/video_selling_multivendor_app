import 'package:get/get.dart';

import '../controllers/favorite_list_controller.dart';

class FavoriteListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteListController>(
      () => FavoriteListController(),
    );
  }
}
