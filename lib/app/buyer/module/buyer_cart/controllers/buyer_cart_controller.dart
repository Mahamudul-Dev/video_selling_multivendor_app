import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:video_selling_multivendor_app/app/routes/app_pages.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/cart.model.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';

class BuyerCartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxDouble totalCartItemPrice = 00.00.obs;
  RxBool isLoading = false.obs;
  RxBool cartLoading = false.obs;
  RxBool cartRemoveLoading = false.obs;

  Future<void> addToCart(ProductModel? item) async {
    if (item != null) {
      cartLoading.value = true;
      final response = await CartConnection.addCartItem(item.id!);

      if (response.statusCode == 200) {
        cartLoading.value = false;

        cartItems.add(CartItem(
            title: item.title,
            price: item.price,
            duration: item.duration,
            thumbnail: item.thumbnail,
            author: item.author));
        totalCartItemPrice.value =
            totalCartItemPrice.value + double.parse(item.price.toString());
        Get.snackbar('Wow!', 'Video added successfully to cart');
      } else {
        cartLoading.value = false;
        Get.snackbar('Sorry', 'There are some error!');
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
          totalCartItemPrice.value - cartItems[index].price!;
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

  Future<List<CartItem>> getAllCartItems() async {
    cartItems.value.clear();
    totalCartItemPrice.value = 00.00;
    final response = await CartConnection.viewCartItem();
    if (response.statusCode == 200) {
      Logger().i({'Cart Response': response.body});
      final data = CartItemModel.fromJson(jsonDecode(response.body));
      cartItems.value.addAll(data.cartItems ?? []);
      cartItems.refresh();
      for (var item in cartItems.value) {
        totalCartItemPrice.value = totalCartItemPrice.value + item.price!;
        Logger().i('Price $totalCartItemPrice');
      }
    }
    update();
    Logger().i(cartItems.value.length);
    return cartItems.value;
  }

  Future<void> viewProduct(int index) async {
    isLoading.value = true;

    final response = await ProductsConnection.getSingleProduct(
        cartItems.value[index].productId!);

    if (response.statusCode == 200) {
      isLoading.value = false;
      final ProductModel product =
          ProductModel.fromJson(jsonDecode(response.body));
      Get.toNamed(Routes.BUYER_PRODUCT_DETAILS,
          arguments: {'product': product});
    } else {
      isLoading.value = false;
      Get.snackbar('Opps', 'Product not found');
    }
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
    cartLoading.close();
    cartRemoveLoading.close();
    super.onClose();
  }
}
