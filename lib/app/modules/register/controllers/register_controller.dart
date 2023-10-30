import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_selling_multivendor_app/app/routes/app_pages.dart';

import '../../../../connections/authentication.dart';
import '../../../preferences/local_preferences.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isSeller = false.obs;
  RxBool isBuyer = false.obs;
  RxBool isLoading = false.obs;
  RxBool obsecure = true.obs;
  final uuid = const Uuid();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void toggleSeller(bool? value) {
    isSeller.value = value ?? false;
    isBuyer.value = false;
  }

  void toggleBuyer(bool? value) {
    isBuyer.value = value ?? false;
    isSeller.value = false;
  }

  bool isEmailValid(String email) {
    // Define a regular expression pattern for email validation
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Use the RegExp `hasMatch` method to check if the email matches the pattern
    return emailRegExp.hasMatch(email);
  }

  String splitUserName({required String sentence}) {
    // Split the sentence into words
    List<String> words = sentence.split(' ');

    if (words.isNotEmpty) {
      // Extract the first word
      String firstWord = words[0];
      return firstWord;
    } else {
      return '';
    }
  }

  Future<void> registerNewAccount() async {
    isLoading.value = true;
    if (isSeller.value || isBuyer.value) {
      if (isSeller.value) {
        // go seller home page
        isLoading.value = false;
        Get.snackbar('Opps', 'Seller account cant accepted right now!');
      } else {
        isLoading.value = true;
        final response = await Authentication.regsterConnection(
            name: nameController.text,
            userName:
                '@${splitUserName(sentence: nameController.text.trim())}${uuid.v1()}',
            email: emailController.text,
            password: passwordController.text,
            accountType: isSeller.value ? 'Seller' : 'Buyer');

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // account created go to next routes

          LocalPreferences.saveCurrentLogin(
              data['_id'], data['email'], data['token'], data['accountType']);
          isLoading.value = false;
          Get.snackbar('Congrats!', 'You successfully created your account');
          Get.offAllNamed(Routes.HOME_BUYER);
        }
      }
    } else {
      isLoading.value = false;
      Get.snackbar('Sorry', 'You must select a account type');
    }
  }

  // dispose all reactive variable
  void disposeReasorce() {
    isSeller.close();
    isBuyer.close();
    isLoading.close();
    obsecure.close();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void onClose() {
    disposeReasorce();
    super.onClose();
  }
}
