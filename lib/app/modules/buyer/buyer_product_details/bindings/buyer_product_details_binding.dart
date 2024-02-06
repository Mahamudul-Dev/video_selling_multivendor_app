import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/modules/buyer/buyer_cart/controllers/buyer_cart_controller.dart';
import 'package:video_selling_multivendor_app/app/modules/buyer/favorite_list/controllers/favorite_list_controller.dart';
import 'package:video_selling_multivendor_app/app/modules/buyer/wish_list/controllers/wish_list_controller.dart';

import '../controllers/buyer_product_details_controller.dart';

class BuyerProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerProductDetailsController>(
      () => BuyerProductDetailsController(),
    );

    Get.lazyPut<BuyerCartController>(
          () => BuyerCartController(),
    );

    Get.lazyPut<WishListController>(
          () => WishListController(),
    );

    Get.lazyPut<FavoriteListController>(
          () => FavoriteListController(),
    );

    // Get.put<DeepLinkController>(DeepLinkController());
  }
}
