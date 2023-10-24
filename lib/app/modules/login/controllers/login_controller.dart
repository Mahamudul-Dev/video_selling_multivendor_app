import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../../../../connections/authentication.dart';
import '../../../preferences/local_preferences.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final _googleSignIn = GoogleSignIn();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool obsecure = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<GoogleSignInAccount?> googleAccount = Rx<GoogleSignInAccount?>(null);

  Future<void> signInWithGoogle() async {
    try {
      googleAccount.value = await _googleSignIn.signIn();
      Logger().i({"logged in account": googleAccount.value?.displayName});
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> signInWithEmail() async {
    isLoading.value = true;
    Logger().i(
        {'email': emailController.text, 'password': passwordController.text});
    final response = await Authentication.loginConnection(
        email: emailController.text, password: passwordController.text);

    if (response.statusCode == 200) {
      // account created go to next routes
      final token = response.data['token'];
      final email = response.data['email'];
      final acountType = response.data['acountType'];
      LocalPreferences.saveCurrentLogin(email, token, acountType);

      isLoading.value = false;
      Get.snackbar('Congrats!', 'You successfully created your account');
      if (acountType == 'buyer') {
        Get.offAllNamed(Routes.HOME_BUYER);
      } else {
        Get.snackbar('Opps', 'Seller side is not ready yet');
      }
    } else {
      isLoading.value = false;
      Get.snackbar('Opps', 'check your credentials');
    }
  }

  bool isEmailValid(String email) {
    // Define a regular expression pattern for email validation
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // Use the RegExp `hasMatch` method to check if the email matches the pattern
    return emailRegExp.hasMatch(email);
  }

  @override
  void onClose() {
    googleAccount.close();
    obsecure.close();
    super.onClose();
  }
}
