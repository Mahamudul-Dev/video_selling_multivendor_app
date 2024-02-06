import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../../connections/products.connection.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/utils/constants.dart';


class GlobalVideoPlayerController extends GetxController {

  RxString videoRatio = 'L'.obs;
  bool isRatioDetected = false;
  PodPlayerController? playerController;

  RxString productTitle = ''.obs;
  RxString productDescription = ''.obs;


  Future<PodPlayerController?> getPlayerController(String productId) async {
    final response = await ProductsConnection.getSingleProduct(productId);

    if (response.statusCode == 200) {
      final productModel = ProductModel.fromJson(jsonDecode(response.body));
      final videoUrl = BASE_URL + productModel.downloadUrl.toString();
      Logger().i("Video URL: $videoUrl");

      productTitle.value = productModel.title ?? '';
      productDescription.value = productModel.description ?? '';

      playerController = PodPlayerController(
          playVideoFrom: PlayVideoFrom.network(videoUrl),
          podPlayerConfig: const PodPlayerConfig(
              autoPlay: false,
              isLooping: false,
              videoQualityPriority: [720, 360]))
        ..initialise();

      // Check if playerController is not null and isPortrait.value is not null
      Logger().i({"Player Controller Status:": playerController != null});

    } else {
      // Handle the case when response status code is not 200
      // You can return null or some other value indicating failure.
      return null;
    }

    try{
      if(playerController != null){
        playerController!.addListener(() {
          if(!isRatioDetected){
            final ratio = playerController?.videoPlayerValue?.aspectRatio;
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
      }
      Logger().e({"Player Controller Video URL": playerController?.videoPlayerValue});
    } catch (e){
      Logger().e(e);
    }
    return playerController;
  }



  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    videoRatio.close();
    playerController?.dispose();
  }
}
