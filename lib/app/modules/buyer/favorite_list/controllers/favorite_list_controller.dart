import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../connections/favourite.connection.dart';
import '../../../../data/models/favourite.model.dart';


class FavoriteListController extends GetxController {

  RxList<FavouriteItem> favouriteProducts = <FavouriteItem>[].obs;
  RxBool isLoading = false.obs;

  String? favoriteId;

  Future<List<FavouriteItem>> getFavoriteProducts() async {
    favouriteProducts.value.clear();
    final response = await FavouriteConnection.viewFavouriteItem();

    if (response.statusCode == 200) {
      final favoriteResponse = FavouriteModel.fromJson(jsonDecode(response.body));
      try {
        favouriteProducts.addAll(favoriteResponse.favouriteItems?.toList() ?? []);
        favoriteId = favoriteResponse.favouriteId;
      } catch (e) {
        Logger().e(e);
      }
    }

    return favouriteProducts.value;
  }


  Future<void> removeFromFavourite(String id) async {
    isLoading.value =true;
    final response = await FavouriteConnection.removeFavouriteItem(id, favoriteId!);

    Logger().i('On Remove Called. Response: ${response.body}');

    if (response.statusCode == 200) {
      try {
        favouriteProducts.removeWhere((element) => element.productId == id);
      } catch (e) {
        Logger().e(e);
      }
    }
    isLoading.value = false;
  }

}
