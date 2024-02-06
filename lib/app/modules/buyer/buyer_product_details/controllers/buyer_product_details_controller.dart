import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pod_player/pod_player.dart';
import '../../../../../../connections/connections.dart';
import '../../../../../../connections/favourite.connection.dart';
import '../../../../../../connections/wishlist.connection.dart';
import '../../../../data/models/favourite.model.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../data/models/wishlist.model.dart';
import '../../../../data/utils/constants.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';

class BuyerProductDetailsController extends GetxController {
  late PodPlayerController playerController;
  RxBool isFavourite = false.obs;
  RxBool isWishlist = false.obs;
  RxBool isCartAdded = false.obs;
  RxBool favLoading = false.obs;
  RxBool wishlistLoading = false.obs;

  RxString videoRatio = 'L'.obs;
  bool isRatioDetected = false;

  Future<ProductModel?> getProduct(String productId) async {
    final response = await ProductsConnection.getSingleProduct(productId);
    final favResponse = await FavouriteConnection.viewFavouriteItem();
    final wishlistResponse = await WishlistConnection.viewWishlistItem();

    if(response.statusCode == 200){
      Logger().i(response.body);
      try{
        final productModel = ProductModel.fromJson(jsonDecode(response.body));
        if (favResponse.statusCode == 200) {
          try {
            final favItem = FavouriteModel.fromJson(jsonDecode(favResponse.body));

            final targetItem = favItem.favouriteItems
                ?.firstWhereOrNull((product) => product.productId == productId);

            if (targetItem != null && targetItem.productId == productId) {
              isFavourite.value = true;
            }
          } catch (e) {
            Logger().e(e);
          }
        } else {
          Logger().e(favResponse.body);
        }

        if (wishlistResponse.statusCode == 200) {
          try {
            final wishItem =
            WishlistModel.fromJson(jsonDecode(wishlistResponse.body));
            Logger().i(wishItem);

            final targetItem = wishItem.wishlistItems
                ?.firstWhereOrNull((product) => product.productId == productId);
            Logger().i({'Wishlist Item': targetItem?.title});
            if (targetItem != null && targetItem.productId == productId) {
              isWishlist.value = true;
            }
          } catch (e) {
            Logger().e(e);
          }
        } else {
          Logger().e(wishlistResponse.body);
        }

        // check product is already in cart or not
        final cartProduct = Get.find<BuyerCartController>()
            .cartItems
            .firstWhereOrNull((element) => element.productId == productId);

        if (cartProduct != null) {
          isCartAdded.value = true;
        }
        return productModel;
      } catch (e){
        throw Exception(e);
      }
    } else {
      return null;
    }
  }

  Future<PodPlayerController> getPlayerController(
      String videoUrl) async {
    Logger().i(videoUrl);
    playerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(BASE_URL + videoUrl),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: false,
            isLooping: false,
            videoQualityPriority: [720, 360]))
      ..initialise();


    try{
      playerController.addListener(() {
        if(!isRatioDetected){
          final ratio = playerController.videoPlayerValue?.aspectRatio;
          Logger().i({'Ratio: ': ratio});
          if(ratio == 0.5625){
            videoRatio.value = 'P';
          } else if(ratio == 1.7777777777777777){
            videoRatio.value = 'L';
          } else {
            videoRatio.value = 'S';
          }
        }
      });
      Logger().e({"Player Controller Video URL": playerController.videoPlayerValue});
    } catch (e){
      Logger().e(e);
    }

    return playerController;
  }

  Future<Profile?> getProductAuthor({required String id}) async {
    ProfileModel? profile;
    final response = await ProfileConnection.userProfileConnection(id: id);
    Logger().i({'Profile Response': response.statusCode});

    if (response.statusCode == 200) {
      profile = ProfileModel.fromJson(jsonDecode(response.body));
    }

    Logger().i({'Profile': profile?.toJson()});

    return profile?.data?.first;
  }

  Future<void> addFavorite(String productId, BuildContext context) async {
    favLoading.value = true;
    final response = await FavouriteConnection.addFavouriteItem(productId);

    if (response.statusCode == 200) {
      isFavourite.value = true;
      favLoading.value = false;
      Get.rawSnackbar(
          messageText: Text(
            'Product added to favourite.',
            style: Theme.of(context)
                .textTheme
                .labelMedium
          ));
    } else {
      favLoading.value = false;
      Logger().i(response.body);
      Get.snackbar('Opps', 'There are some error');
    }
  }

  Future<void> addWishlist(String productId, BuildContext context) async {
    wishlistLoading.value = true;
    final response = await WishlistConnection.addWishlistItem(productId);

    if (response.statusCode == 200) {
      isWishlist.value = true;
      wishlistLoading.value = false;
      Get.rawSnackbar(
          messageText: Text(
            'Product added to wishlist.',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Colors.white),
          ));
    } else {
      wishlistLoading.value = false;
      Logger().i(response.body);
      Get.snackbar('Opps', 'There are some error');
    }
  }


  @override
  void onClose() {
    playerController.dispose();
    isFavourite.close();
    isWishlist.close();
    favLoading.close();
    wishlistLoading.close();
    isCartAdded.close();
    super.onClose();
  }
}
