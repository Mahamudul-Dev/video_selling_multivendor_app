import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../connections/connections.dart';
import '../../../../data/models/profile.model.dart';
import '../../../../data/preferences/local_preferences.dart';
import '../../../../data/utils/constants.dart';
import '../../../../routes/app_pages.dart';

class BuyerProfileController extends GetxController {
  RxList<String> interestTags = <String>[].obs;
  RxBool isUpdating = false.obs;
  RxString username = ''.obs;
  RxString displayName = ''.obs;
  RxString userEmail = ''.obs;
  RxBool emailVerified = false.obs;
  RxBool isUserNameChanged = false.obs;
  RxString userProfileImageUrl = ''.obs;
  Rx<XFile?> pickedImage = Rx(null);

  TextEditingController displayNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController interestInputController = TextEditingController();



  Future<ProfileModel?> getProfile() async {
    ProfileModel? profile;
    final response = await ProfileConnection.userProfileConnection(
        id: LocalPreferences.getCurrentLoginInfo().id!);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      profile = ProfileModel.fromJson(data);
    } else if (response.statusCode == 400) {
      Get.snackbar('Opps', response.body);
    } else {
      Get.snackbar('Opps', 'Please check your conectivity');
    }
    if (profile != null) {
      username.value = profile.data?.first.userName ?? '';
      displayName.value = profile.data?.first.name ?? '';
      displayNameController.text = displayName.value;
      userEmail.value = profile.data?.first.email ?? '';
      emailVerified.value = profile.data?.first.isEmailVerified ?? false;
      isUserNameChanged.value = profile.data?.first.userNameChanged ?? false;
      if (profile.data?.first.profilePic != 'N/A') {
        userProfileImageUrl.value = BASE_URL + profile.data!.first.profilePic!;
      }
      interestTags.value
          .addAll(profile.data?.first.interest as Iterable<String>);
    }
    return profile;
  }

  Future<void> updateProfile() async {
    isUpdating.value = true;
    final Map<String, dynamic> profileData = {
      "name": displayNameController.text,
      "interest": interestTags.value
    };

    Logger().i(profileData);

    try {
      
    final response = await ProfileConnection.updateUserProfileConnection(
        id: LocalPreferences.getCurrentLoginInfo().id!, bodyData: profileData);

    if (response.statusCode == 200) {
      // profile updated
      isUpdating.value = false;
      Get.snackbar('Success', 'Profile Information Updated');
    } else {
      isUpdating.value = false;
      Get.snackbar('Opps', response.body);
    }
    } catch (e) {
      Logger().e(e);
    }
  }

  void onInterestAdd() {
    if (interestInputController.text != '') {
      if (interestTags.value.contains(interestInputController.text)) {
        Get.snackbar('Sorry', 'Keyword already added!');
      } else {
        interestTags.value.add(interestInputController.text);
        interestTags.refresh();
        interestInputController.clear();
      }
    }
  }

  void onInterestRemove(String value) {
    interestTags.value.removeWhere((element) => element == value);
    interestTags.refresh();
  }

  String formatNumber(int number) {
    final format = NumberFormat.compact();
    return format.format(number);
  }

  Future<void> getImage() async {
    late PermissionStatus status;

    if (Platform.isAndroid) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final picker = ImagePicker();
      final imageFile = await picker.pickImage(source: ImageSource.gallery);
      pickedImage.value = imageFile;

      if (imageFile != null) {
        final response =
            await ProfileConnection.uploadProfileImage(imageFile.path);
        Logger().d({
          'Response Stream': response.stream,
          'Response Length': response.contentLength,
          'Respose Status Code': response.statusCode,
          'Response Body': response.reasonPhrase
        });
        if (response.statusCode == 200) {
          Get.snackbar('Great', 'Your new profile photo updated');
        }
      }
    } else if (status.isDenied) {
      // Handle denied permission
      Get.snackbar('Opps',
          'You need to give us permission for update your profile photo');
    } else if (status.isPermanentlyDenied) {
      // Handle permanently denied permission
      Get.snackbar('Sorry',
          'You can not update your profile photo. Please retry after giving the permission');
    }
  }

  Future<bool> checkUsernameAvailablity()async{
    return Future.value(true);
  }

  Future<void> updateUsername()async{}

  void logout(){
    LocalPreferences.removeToken();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    interestTags.close();
    isUpdating.close();
    username.close();
    displayName.close();
    userEmail.close();
    userProfileImageUrl.close();
    displayNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    interestInputController.dispose();
    super.onClose();
  }
}
