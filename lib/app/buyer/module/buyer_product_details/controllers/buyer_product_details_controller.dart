import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';

class BuyerProductDetailsController extends GetxController {
  Future<PodPlayerController> getPlayerController(String videoUrl) async {
    PodPlayerController playerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(videoUrl),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: false,
            isLooping: false,
            videoQualityPriority: [720, 360]))
      ..initialise();

    return playerController;
  }

  Future<ProductModel?> getProductDetails(String productId) async {
    ProductModel? product;
    final response = await ProductsConnection.getSingleProduct(productId);

    if (response.statusCode == 200) {
      product = ProductModel.fromJson(jsonDecode(response.body));
    } else {
      Get.snackbar('Opps', 'Error loading data');
    }

    return product;
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
}
