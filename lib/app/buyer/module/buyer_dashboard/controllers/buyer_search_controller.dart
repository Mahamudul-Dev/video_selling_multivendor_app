import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';

class BuyerSearchController extends GetxController {
  List<ProductModel> searchResult = <ProductModel>[];
  RxList<ProductModel> filteredResult = <ProductModel>[].obs;
  RxList<Author> filteredCreatorList = <Author>[].obs;
  RxList<Author> creatorList = <Author>[].obs;
  TextEditingController filterMinPrice = TextEditingController();
  TextEditingController filterMaxPrice = TextEditingController();
  RxBool filterPriceLowToHigh = false.obs;
  RxDouble filterRating = 0.0.obs;

  Future<List<ProductModel>> searchVideo(String query) async {
    final response = await ProductsConnection.searchProduct(query);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Logger().i(result);
      searchResult.clear();
      creatorList.clear();

      for (var i = 0; i < result.length; i++) {
        searchResult.add(ProductModel.fromJson(result[i]));
        if (!creatorList.value.contains(ProductModel.fromJson(result[i]).author!)) {
          creatorList.add(ProductModel.fromJson(result[i]).author!);
        }
      }
    }

    return searchResult;
  }

  void filterSearchList() {
    filteredResult.value.clear();
    try {
      if (filterMinPrice.text != '') {
        Logger().i({'Filter Min Price': filterMinPrice.text});
        // filtered minimum price is setted
        if (filterMaxPrice.text != '') {
          Logger().i({'Filter Max Price': filterMaxPrice.text});
          // filtered maximum price is setted
          filteredResult.value.addAll(searchResult.where((product) =>
              product.price! <=
                  double.parse(filterMaxPrice.text) &&
              product.price! >
                  double.parse(filterMinPrice.text)));
        } else {
          // filterred max price not setted that's means infinity
          filteredResult.value.addAll(searchResult.where((product) =>
              product.price! >
              double.parse(filterMinPrice.text)));
        }
      }

      if (filterPriceLowToHigh.value) {
        // check first previous filtering exist or not
        if (filteredResult.value.isNotEmpty) {
          filteredResult.value.sort((a, b) => a.price!.compareTo(b.price!));
        } else {
          // no price renge is valid for this now
          filteredResult.value.addAll(searchResult);
          filteredResult.sort((a, b) => a.price!.compareTo(b.price!));
        }
      }

      if (filterRating > 0.0) {
        // rating filter is on
        // first check already any filter is added or not
        if (filteredResult.value.isNotEmpty) {
          filteredResult.removeWhere(
              (product) => product.ratings?.toDouble() == filterRating.value);
        }
      }


       if (filteredResult.isNotEmpty) {
         for (var i = 0; i < filteredResult.length; i++) {
           if (!filteredCreatorList.value.contains(filteredResult[i].author!)) {
          filteredCreatorList.add(filteredResult[i].author!);
        }
         }
       }

    } catch (e) {
      Logger().i(e);
    }

    Get.back();
  }

  void clearFilter() {
    filterMaxPrice.clear();
    filterMinPrice.clear();
    filterPriceLowToHigh.value = false;
    filterRating.value = 0.0;
    filteredResult.value.clear();
    filteredCreatorList.value.clear();
    Get.back();
  }

  Future<Profile?> getProfile({required String id}) async {
    ProfileModel? profile;
    final response = await ProfileConnection.userProfileConnection(id: id);
    Logger().i({'Profile Response': response.statusCode});

    if (response.statusCode == 200) {
      profile = ProfileModel.fromJson(jsonDecode(response.body));
    }

    Logger().i({'Profile': profile?.toJson()});

    return profile?.data?.first;
  }

  Future<PodPlayerController> getPlayerController(String trailerVideo) async {
    PodPlayerController playerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(trailerVideo),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: false,
            isLooping: false,
            videoQualityPriority: [720, 360]))
      ..initialise();

    return playerController;
  }

  @override
  void onClose() {
    filterMinPrice.dispose();
    filterMaxPrice.dispose();
    filterPriceLowToHigh.close();
    filterRating.close();
    filteredCreatorList.close();
    creatorList.clear();
    super.onClose();
  }
}
