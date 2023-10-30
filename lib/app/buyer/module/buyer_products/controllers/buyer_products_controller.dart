import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../connections/connections.dart';
import '../../../../models/product.model.dart';
import '../../../../models/product_filter.enum.dart';
import '../../../../models/profile.model.dart';

class BuyerProductsController extends GetxController {
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

  Future<List<ProductModel>> getFilterdVideo(Filter filter) async {
    List<ProductModel> products = [];
    final response = await ProductsConnection.getProductByFilter(filter);

    Logger().i({'Filterd Video': response.statusCode});
    Logger().i({'Filterd Video Data': response.body});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (var i = 0; i < data.length; i++) {
        Logger().i(i);
        products.add(ProductModel.fromJson(data[i]));
      }
    }

    return products;
  }
}
