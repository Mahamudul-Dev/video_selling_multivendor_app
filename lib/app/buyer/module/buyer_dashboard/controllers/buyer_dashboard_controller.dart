import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pod_player/pod_player.dart';
import '../../../../../connections/connections.dart';
import '../../../../models/product.model.dart';
import '../../../../models/product_filter.enum.dart';
import '../../../../models/profile.model.dart';

class BuyerDashboardController extends GetxController {
  List<ProductModel> topSaleProducts = <ProductModel>[];
  List<ProductModel> topRatedProducts = <ProductModel>[];
  List<ProductModel> youMayLikeProducts = <ProductModel>[];
  ScrollController scrollController = ScrollController();
  late PersistentBottomSheetController controller;
  Future<void> refrashPage() async {
    return await Future.delayed(const Duration(seconds: 1));
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

  Future<List<ProductModel>> initializeTopSaleProducts() async {
    topSaleProducts.clear();
    final response =
        await ProductsConnection.getProductByFilter(Filter.SALEH2L);

    Logger().i({'Top Sale': response.body});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        Logger().i(i);
        topSaleProducts.add(ProductModel.fromJson(data[i]));
      }
    }
    return topSaleProducts;
  }

  Future<List<ProductModel>> initializeTopRatedProducts() async {
    topRatedProducts.clear();
    final response =
        await ProductsConnection.getProductByFilter(Filter.RATINGH2L);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        Logger().i(i);
        topRatedProducts.add(ProductModel.fromJson(data[i]));
      }
    }
    return topRatedProducts;
  }

  Future<List<ProductModel>> initializeYouMayLikeProducts() async {
    youMayLikeProducts.clear();
    final response =
        await ProductsConnection.getProductByFilter(Filter.PRICEL2H);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        Logger().i(i);
        youMayLikeProducts.add(ProductModel.fromJson(data[i]));
      }
    }
    return youMayLikeProducts;
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

  Future<void> onRefrash() async {}
}
