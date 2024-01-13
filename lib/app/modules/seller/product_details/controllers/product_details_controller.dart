import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/product.model.dart';
import '../../../../routes/app_pages.dart';

class ProductDetailsController extends GetxController {
  

  Future<void> getProductDetails(String id)async{
    final response = await ProductsConnection.getSingleProduct(id);

    if (response.statusCode == 200) {
      final ProductModel product =
          ProductModel.fromJson(jsonDecode(response.body));
      Get.toNamed(Routes.BUYER_PRODUCT_DETAILS,
          arguments: {'product': product});
    } else {
      Get.snackbar('Opps', 'Product not found');
    }
  } 
}
