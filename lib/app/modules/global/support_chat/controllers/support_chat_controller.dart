import 'dart:convert';

import 'package:get/get.dart';

import '../../../../../connections/connections.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../preferences/local_preferences.dart';

class SupportChatController extends GetxController {
  
  Future<Profile?> getProfileDetails() async {
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
}
