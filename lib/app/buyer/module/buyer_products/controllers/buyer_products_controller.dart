import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../data/utils/enums.dart';

class BuyerProductsController extends GetxController {
  Future<PodPlayerController> getPlayerController(String trailerVideo) async {
    PodPlayerController playerController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(trailerVideo),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true, isLooping: false, videoQualityPriority: [720, 360]))
      ..initialise();

    return playerController;
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

  Future<List<ProductModel>> getFilterdVideo(Filter filter) async {
    List<ProductModel> products = [];
    final response = await ProductsConnection.getProductByFilter(filter);

    Logger().i({'Filterd Video': response.statusCode});
    Logger().i({'Filterd Video Data': response.body});

    try {
      if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        Logger().i(i);
        products.add(ProductModel.fromJson(data[i]));
      }
    }
    } catch (e) {
      Logger().e(e);
    }

    return products;
  }
}
