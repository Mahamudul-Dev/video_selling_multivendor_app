import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../connections/authentication.dart';
import '../../../../models/profile.model.dart';
import '../../../../preferences/local_preferences.dart';

class BuyerProfileController extends GetxController {
  Future<ProfileModel?> getProfile() async {
    ProfileModel? profile;
    final response = await Authentication.userProfileConnection(
        id: LocalPreferences.getCurrentLoginInfo().id);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      profile = ProfileModel.fromJson(data);
    } else if (response.statusCode == 400) {
      Get.snackbar('Opps', response.body);
    } else {
      Get.snackbar('Opps', 'Please check your conectivity');
    }
    // Logger().i('Profile: ${profile.profile}')
    return profile;
  }
}
