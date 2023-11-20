import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/cart.model.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';

class BuyerCartController extends GetxController {
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  RxDouble totalCartItemPrice = 00.00.obs;
  RxBool isLoading = false.obs;
  RxBool cartRemoveLoading = false.obs;

  Future<void> addToCart(ProductModel? item) async {
    if (item != null) {
      final response = await CartConnection.addCartItem(item.id!);
      final authorResponse =
          await ProfileConnection.userProfileConnection(id: item.author!);

      if (response.statusCode == 200 && authorResponse.statusCode == 200) {
        final author = ProfileModel.fromJson(jsonDecode(authorResponse.body));
        cartItems.add(CartItemModel(
            title: item.title,
            price: item.price,
            duration: item.duration,
            thumbnail: item.thumbnail,
            author: Author(
                name: author.data?.first.name,
                profilePic: author.data?.first.profilePic,
                country: author.data?.first.country,
                city: author.data?.first.city)));
        totalCartItemPrice.value =
            totalCartItemPrice.value + double.parse(item.price!);
        Get.snackbar('Wow!', 'Video added successfully to cart');
      }
    }
  }

  Future<void> removeToCart(int index) async {
    Logger().i('Remove Cart Exicuting...');
    cartRemoveLoading.value = true;
    final response =
        await CartConnection.removeCartItem(cartItems[index].productId!);
    Logger().i(response.body);
    if (response.statusCode == 200) {
      totalCartItemPrice.value =
          totalCartItemPrice.value - double.parse(cartItems[index].price!);
      cartItems.removeAt(index);
      cartRemoveLoading.value = false;
      Get.back();
    } else {
      cartRemoveLoading.value = false;
      Get.snackbar('Opps!', response.body);
      Get.back();
    }
  }

  void checkout() {
    // TO:DO: add payment processing functionality

    Get.snackbar('Opps', 'Checkout is not added yet');
  }

  Future<Profile?> getProfile({required id}) async {
    ProfileModel? profile;
    final response = await ProfileConnection.userProfileConnection(id: id);

    if (response.statusCode == 200) {
      profile = ProfileModel.fromJson(jsonDecode(response.body));
    }

    return profile?.data?.first;
  }

  Future<List<CartItemModel>> getAllCartItems() async {
    cartItems.value.clear();
    totalCartItemPrice.value = 00.00;
    final response = await CartConnection.viewCartItem();
    if (response.statusCode == 200) {
      Logger().i({'Cart Response': response.body});
      final data = CartModel.fromJson(jsonDecode(response.body));
      cartItems.value.addAll(data.cartItems ?? []);
      cartItems.refresh();
      for (var item in cartItems.value) {
        totalCartItemPrice.value =
            totalCartItemPrice.value + double.parse(item.price ?? '00.00');
        Logger().i('Price $totalCartItemPrice');
      }
    }
    update();
    return cartItems.value;
  }

  @override
  void onReady() async {
    // await getAllCartItems();
    super.onReady();
  }

  @override
  void onClose() {
    cartItems.close();
    totalCartItemPrice.close();
    isLoading.close();
    cartRemoveLoading.close();
    super.onClose();
  }
}
