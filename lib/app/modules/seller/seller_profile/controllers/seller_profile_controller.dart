import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../../connections/profile.connection.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../data/preferences/local_preferences.dart';
import '../../../../routes/app_pages.dart';

class SellerProfileController extends GetxController {

  void copySellerIdToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar('', 'Seller username copied into clipboard');
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

  void logout(){
    LocalPreferences.removeToken();
    Get.offAllNamed(Routes.LOGIN);
  }
}
