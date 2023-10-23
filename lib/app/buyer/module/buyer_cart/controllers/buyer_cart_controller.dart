import 'package:get/get.dart';

import '../../../../models/cart_item.model.dart';
import '../../../../models/video_item.model.dart';

class BuyerCartController extends GetxController {
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  RxDouble totalCartItemPrice = 00.00.obs;

  void addToCart(VideoItemModel item) {
    cartItems.add(CartItemModel(
        id: item.id,
        title: item.title,
        description: item.description,
        category: item.category,
        price: item.price,
        duration: item.duration,
        thumbnail: item.thumbnail,
        previewUrl: item.previewUrl,
        author: item.author));
    totalCartItemPrice.value =
        totalCartItemPrice.value + double.parse(item.price!);
    Get.snackbar('Wow!', 'Video added successfully to cart');
  }

  void removeToCart(int index) {
    totalCartItemPrice.value =
        totalCartItemPrice.value - double.parse(cartItems[index].price!);
    cartItems.removeAt(index);
    Get.back();
  }

  void checkout() {
    // TO:DO: add payment processing functionality

    Get.snackbar('Opps', 'Checkout is not added yet');
  }

  @override
  void onClose() {
    cartItems.close();
    totalCartItemPrice.close();
    super.onClose();
  }
}
