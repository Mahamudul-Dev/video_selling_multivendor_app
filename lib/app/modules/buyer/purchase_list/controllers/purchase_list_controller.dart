import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:video_selling_multivendor_app/app/data/models/profile.model.dart';
import 'package:video_selling_multivendor_app/app/modules/buyer/buyer_profile/controllers/buyer_profile_controller.dart';
import 'package:video_selling_multivendor_app/connections/connections.dart';

import '../../../../data/models/favourite.model.dart';
import '../../../../data/preferences/local_preferences.dart';

class PurchaseListController extends GetxController {

  RxList<PurchaseList> purchaseList = <PurchaseList>[].obs;


  Future<List<PurchaseList>> getPurchaseList() async {
    purchaseList.clear();

    final currentBuyerProfile = await Get.find<BuyerProfileController>().getProfile();

    purchaseList.addAll(currentBuyerProfile!.data!.first.purchaseList!);

    return purchaseList;
  }
}
