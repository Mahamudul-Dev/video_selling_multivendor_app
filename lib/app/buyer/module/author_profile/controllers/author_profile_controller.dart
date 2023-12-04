import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:video_selling_multivendor_app/connections/connections.dart';

import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';

class AuthorProfileController extends GetxController {
  

  Future<ProfileModel?> getAuthorProfile(String id)async{
    ProfileModel? profile;
    final response = await ProfileConnection.userProfileConnection(id: id);
    if (response.statusCode == 200) {
      profile = ProfileModel.fromJson(jsonDecode(response.body));
    } else if(response.statusCode == 400){
      Get.snackbar('Sorry', 'Author Id incorrect!');
    } else {
      Get.snackbar('Sorry', 'Server busy!');
    }
    return profile;
  }


  Future<List<ProductModel>> getAuthorProducts(String username) async {
    final List<ProductModel> productList = [];
    final response = await ProductsConnection.searchProduct(username);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Logger().i(result);
      productList.clear();

      for (var i = 0; i < result.length; i++) {
        productList.add(ProductModel.fromJson(result[i]));
        
      }
    }

    return productList;
  }

  void copyAuthorIdToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar('', 'Author username copied into clipboard');
  }

  String formatNumber(int number) {
    final format = NumberFormat.compact();
    return format.format(number);
  }


  
}
