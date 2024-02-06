import 'package:get/get.dart';

import '../app/routes/app_pages.dart';

class DeepLinkController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    handleDeepLink();
  }

  void handleDeepLink() {
    String? productId = Get.parameters['productId'];

    // Log the link to check if it's being received
    print('Received deep productId: $productId');

    if (productId != null) {
      // Parse the deep link and extract necessary information
      if (productId.contains(Routes.BUYER_PRODUCT_DETAILS)) {

        // Navigate to the 'Home' screen first
        Get.offAndToNamed(Routes.BUYER_PRODUCT_DETAILS, parameters: {'productId': productId});
      }
    }
  }
}
