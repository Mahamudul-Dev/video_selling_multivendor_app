import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../../connections/connections.dart';
import '../../../../models/product.model.dart';
import '../../../../models/profile.model.dart';

class BuyerDashboardController extends GetxController {
  RxList<ProductModel> trendingVideos = <ProductModel>[].obs;
  ScrollController scrollController = ScrollController();
  Future<void> refrashPage() async {
    return await Future.delayed(const Duration(seconds: 1));
  }

  Future<RxList<ProductModel>> initializeTrendingVideos() async {
    trendingVideos.clear();
    final response = await ProductsConnection.getAllProducts();
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        Logger().i(i);
        trendingVideos.add(ProductModel.fromJson(data[i]));
      }
    }
    return trendingVideos;
  }

  Future<Profile?> getProfile({required String id}) async {
    ProfileModel? profile;
    final response = await Authentication.userProfileConnection(id: id);
    Logger().i({'Profile Response': response.statusCode});

    if (response.statusCode == 200) {
      profile = ProfileModel.fromJson(jsonDecode(response.body));
    }

    Logger().i({'Profile': profile?.toJson()});

    return profile?.data?.first;
  }

  Future<void> onRefrash() async {}
  @override
  void onClose() {
    trendingVideos.close();
    super.onClose();
  }
}
