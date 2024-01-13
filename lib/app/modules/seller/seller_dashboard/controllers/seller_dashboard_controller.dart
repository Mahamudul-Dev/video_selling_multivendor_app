import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../../../../../connections/connections.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../data/models/search.model.dart';
import '../../../../data/preferences/local_preferences.dart';

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

  Future<List<ProductModel>> getSellerProducts() async {
    final currentUserInfo = LocalPreferences.getCurrentLoginInfo();
    final sellerResponse =
        await ProfileConnection.userProfileConnection(id: currentUserInfo.id!);

    if (sellerResponse.statusCode == 200) {
      final seller = ProfileModel.fromJson(jsonDecode(sellerResponse.body));
      final response =
          await ProductsConnection.searchProduct(seller.data!.first.userName!);

      Logger().i({'Products': response.body});

      if (response.statusCode == 200) {
        Logger().i(response.body);
        productList.clear();
        Logger().i({'ProductList': productList.value.length});
        try {
          productList.value.addAll(
              SearchResultModel.fromJson(jsonDecode(response.body))
                      .result
                      ?.toList() ??
                  []);
        } catch (e) {
          Logger().e(e);
        }

        Logger().i({'ProductList': productList.value.length});
      }
    }

    return productList.value;
  }

  // String formatDuration(Duration duration) {
  //   String twoDigits(int n) {
  //     if (n >= 10) return "$n";
  //     return "0$n";
  //   }

  //   String hours = duration.inHours > 0 ? "${duration.inHours} hours " : "";
  //   String minutes = duration.inMinutes.remainder(60) > 0
  //       ? "${duration.inMinutes.remainder(60)} min "
  //       : "";
  //   String seconds = duration.inSeconds.remainder(60) > 0
  //       ? "${duration.inSeconds.remainder(60)} sec"
  //       : "";

  //   return "$hours$minutes$seconds";
  // }

  String formatDuration(double durationInMilliseconds) {
    int milliseconds = durationInMilliseconds.floor();
    int seconds = (milliseconds / 1000).floor();
    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();

    milliseconds %= 1000;
    seconds %= 60;
    minutes %= 60;

    List<String> formattedDuration = [];

    if (hours > 0) {
      formattedDuration.add('$hours ${hours == 1 ? 'hour' : 'hours'}');
    }

    if (minutes > 0) {
      formattedDuration.add('$minutes ${minutes == 1 ? 'min' : 'min'}');
    }

    // if (seconds > 0 || (hours == 0 && minutes == 0)) {
    //   formattedDuration.add('${seconds} ${seconds == 1 ? 'sec' : 'seconds'}');
    // }

    // if (milliseconds > 0) {
    //   formattedDuration.add(
    //       '${milliseconds} ${milliseconds == 1 ? 'millisecond' : 'milliseconds'}');
    // }

    return formattedDuration.join(' ');
  }

  @override
  void onClose() {
    productList.close();
    super.onClose();
  }
}
