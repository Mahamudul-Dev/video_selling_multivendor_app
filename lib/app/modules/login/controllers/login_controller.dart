import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

import '../../../../connections/authentication.dart';
import '../../../models/profile.model.dart';
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

  // function for google signin
  Future<void> signInWithGoogle() async {
    try {
      googleAccount.value = await _googleSignIn.signIn();
      Logger().i({"logged in account": googleAccount.value?.displayName});
    } catch (e) {
      Logger().e(e);
    }
  }

  // function for facebook signin
  Future<void> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile', 'email', 'picture'],
    );

    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      final Profile userInformation = Profile(
          name: userCredential.user?.displayName,
          email: userCredential.user?.email ?? userCredential.user?.phoneNumber,
          emailIsVerified: userCredential.user?.emailVerified);

      Get.snackbar('Success', 'Welcomeback ${userInformation.name}');
    } else {
      Get.snackbar('Sorry', 'We are working on this issue, try later');
      Logger().e({'status': result.status, 'message': result.message});
    }
  }

  // function for email & password signin
  Future<void> signInWithEmail() async {
    isLoading.value = true;
    Logger().i(
        {'email': emailController.text, 'password': passwordController.text});
    final response = await Authentication.loginConnection(
        email: emailController.text, password: passwordController.text);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // account created go to next routes
      final id = data['_id'];
      final token = data['token'];
      final email = data['email'];
      final accountType = data['accountType'];
      LocalPreferences.saveCurrentLogin(id, email, token, accountType);

      isLoading.value = false;
      Get.snackbar('Success!', 'Welcome back!');
      if (accountType == 'buyer') {
        Get.offAllNamed(Routes.HOME_BUYER);
      } else {
        Get.snackbar('Opps', 'Seller side is not ready yet');
      }
    } else if (response.statusCode == 400) {
      isLoading.value = false;
      Get.snackbar('Opps', response.body);
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
