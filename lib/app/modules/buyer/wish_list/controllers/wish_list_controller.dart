import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../connections/wishlist.connection.dart';
import '../../../../data/models/wishlist.model.dart';

class WishListController extends GetxController {
  
  RxList<WishlistItem> wishlistProducts = <WishlistItem>[].obs;
  RxBool isLoading = false.obs;

  String? wishlistId;

  Future<List<WishlistItem>> getWishlistProducts() async {
    wishlistProducts.value.clear();
    final response = await WishlistConnection.viewWishlistItem();

    if (response.statusCode == 200) {
      final wishlistResponse = WishlistModel.fromJson(jsonDecode(response.body));
      try {
        wishlistProducts.addAll(wishlistResponse.wishlistItems?.toList() ?? []);
        wishlistId = wishlistResponse.wishlistId;
      } catch (e) {
        Logger().e(e);
      }
    }

    return wishlistProducts.value;
  }


  Future<void> removeFromWishlist(String id) async {
    isLoading.value =true;
    final response = await WishlistConnection.removeWishlistItem(id, wishlistId!);

    Logger().i('On Remove Called. Response: ${response.body}');

    if (response.statusCode == 200) {
      try {
        wishlistProducts.removeWhere((element) => element.productId == id);
      } catch (e) {
        Logger().e(e);
      }
    }
    isLoading.value = false;
  }

}
