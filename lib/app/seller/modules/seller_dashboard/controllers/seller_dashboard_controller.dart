import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../preferences/local_preferences.dart';

class SellerDashboardController extends GetxController {
  RxList<ProductModel> productList = <ProductModel>[].obs;

  // Sample data for the ActivityMonitor widget
  List<double> weeklySalesData = [
    150.0,
    200.0,
    180.0,
    250.0,
    300.0,
    280.0,
    200.0
  ];
// Sample labels for the x-axis (assuming days of the week)
  List<String> yourXAxisLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  // Sample data for the ActivityMonitor widget
  List<double> weeklyClicksData = [27, 67, 12, 88, 100, 200, 126];

  String formatNumber(int number) {
    final format = NumberFormat.compact();
    return format.format(number);
  }

  Future<Profile?> getSellerProfile() async {
    final currentUserInfo = LocalPreferences.getCurrentLoginInfo();
    final sellerResponse =
        await ProfileConnection.userProfileConnection(id: currentUserInfo.id!);

    if (sellerResponse.statusCode == 200) {
      final author = ProfileModel.fromJson(jsonDecode(sellerResponse.body));
      return author.data?.first;
    } else {
      return Future.value(null);
    }
  }

  Future<List<ProductModel>> getSellerProducts() async {
    final currentUserInfo = LocalPreferences.getCurrentLoginInfo();
    final sellerResponse =
        await ProfileConnection.userProfileConnection(id: currentUserInfo.id!);

    if (sellerResponse.statusCode == 200) {
      final seller = ProfileModel.fromJson(jsonDecode(sellerResponse.body));
      final response =
          await ProductsConnection.searchProduct(seller.data!.first.userName!);

      if (response.statusCode == 200) {
        final jsonRes = jsonDecode(response.body);
        for (var i = 0; i < jsonRes.length; i++) {
          productList.add(ProductModel.fromJson(jsonRes[i]));
        }
      }
    }

    return productList.value;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String hours = duration.inHours > 0 ? "${duration.inHours} hours " : "";
    String minutes = duration.inMinutes.remainder(60) > 0
        ? "${duration.inMinutes.remainder(60)} min "
        : "";
    String seconds = duration.inSeconds.remainder(60) > 0
        ? "${duration.inSeconds.remainder(60)} sec"
        : "";

    return "$hours$minutes$seconds";
  }

  @override
  void onClose() {
    productList.close();
    super.onClose();
  }
}
