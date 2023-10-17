import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  RxBool isSeller = false.obs;
  RxBool isBuyer = false.obs;
  RxBool isLoading = false.obs;

  void toggleSeller(bool? value) {
    isSeller.value = value ?? false;
    isBuyer.value = false;
  }

  void toggleBuyer(bool? value) {
    isBuyer.value = value ?? false;
    isSeller.value = false;
  }

  Future<void> registerNewAccount() async {
    isLoading.value = true;
    if (isSeller.value || isBuyer.value) {
      if (isSeller.value) {
        // go seller home page
        isLoading.value = false;
        Get.snackbar('Opps', 'Seller home page is not ready yet');
      } else {
        // go buyer home page
        Future.delayed(const Duration(seconds: 2), () {
          isLoading.value = false;
          Get.offAllNamed(Routes.HOME_BUYER);
        });
      }
    } else {
      isLoading.value = false;
      Get.snackbar('Sorry', 'You must select a account type');
    }
  }

  // dispose all reactive variable
  void disposeReasorce() {
    isSeller.close();
    isBuyer.close();
    isLoading.close();
  }

  @override
  void onClose() {
    disposeReasorce();
    super.onClose();
  }
}
