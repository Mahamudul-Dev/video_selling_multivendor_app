import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../routes/app_pages.dart';

class ProductDetailsController extends GetxController {
  RxBool editModeOn = false.obs;
  RxBool isLoading = false.obs;

  XFile? thumbnailImage;
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  RxString videoCategory = 'Select Category'.obs;
  RxList<String> allCategories = <String>[
    'Select Category',
    'Web Development',
    'App Development',
    'Pet & Animal',
    'Programming',
    'Consultation'
  ].obs;


  void selectCategories(String? category) {
    if (category != null) {
      videoCategory.value = category;
    }
  }

  Future<ProductModel?> getProductDetails(String id) async {
    final response = await ProductsConnection.getSingleProduct(id);
    if (response.statusCode == 200) {
      try {
        final ProductModel product =
            ProductModel.fromJson(jsonDecode(response.body));

        productTitleController.text = product.title ?? '';
        productDescriptionController.text = product.description ?? '';
        productPriceController.text = product.price.toString();

        return product;
      } catch (e) {
        throw Exception(e);
      }
    } else {
      Get.snackbar('Opps', 'Product not found');
      return null;
    }
  }

  Future<Profile?> getSingleProfile(String id) async {
    final response = await ProfileConnection.userProfileConnection(id: id);

    if (response.statusCode == 200) {
      try {
        final profile = ProfileModel.fromJson(jsonDecode(response.body));

        if (profile.data!.isNotEmpty) {
          return profile.data!.first;
        } else {
          return null;
        }
      } catch (e) {
        Logger().e(e);

        throw Exception(e);
      }
    } else {
      return null;
    }
  }

  Future<void> updateProduct(String productId) async {
    if (productTitleController.text == '' &&
        productPriceController.text == '' &&
        productDescriptionController.text == '' &&
        videoCategory.value == 'Select Category') {
      Get.snackbar('Sorry', 'You must need to change any value for update');
    } else {
      isLoading.value = true;
      try {
        final response = await ProductsConnection.updateProduct(productId,
            productName: productTitleController.text,
            price: productPriceController.text ,
            description: productDescriptionController.text,
            category: videoCategory.value);

        Logger().i(response.data);

        if(response.statusCode == 200){
          isLoading.value = false;
          editModeOn.value = false;
          Get.snackbar('Success', 'Product updated successfully');
        }
      } catch (e) {
        isLoading.value = false;
        Logger().e(e);
        Get.snackbar('Opps', 'There was an error!');
      }
    }
  }

  Future<bool> deleteVideo(String productId) async {
    try {
      isLoading.value = true;
      final response = await ProductsConnection.deleteVideo(productId);
      if (response.statusCode == 200) {
        isLoading.value = false;
        return true;
      } else {
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      Logger().e(e);
      isLoading.value = false;
      return false;
    }
  }

  void toggleEditMode() {
    editModeOn.value = !editModeOn.value;
  }
}
