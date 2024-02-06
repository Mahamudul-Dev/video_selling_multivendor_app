import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import '../../../../../connections/authentication.dart';
import '../../../../data/preferences/local_preferences.dart';
import '../../../../routes/app_pages.dart';
import '../../register/controllers/register_controller.dart';

class LoginController extends GetxController {
  // final _googleSignIn = GoogleSignIn();
  final formKey = GlobalKey<FormState>();
  final checkInfoFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool obsecure = true.obs;
  RxBool isSeller = false.obs;
  RxBool isBuyer = false.obs;
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<UserCredential?> googleAccount = Rx<UserCredential?>(null);

  // function for google signin
  Future<void> signInWithGoogle() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      googleAccount.value = await _auth.signInWithProvider(googleAuthProvider);
      Logger().i({"logged in account": googleAccount.value?.user?.email});

      if (googleAccount.value != null) {
        // at first try to login with google credential
        final response = await Authentication.loginConnection(
            email: googleAccount.value!.user!.email!,
            password: googleAccount.value!.user!.uid);

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
            Get.offAllNamed(Routes.SELLER_HOME);
          }
        } else if (response.statusCode == 400) {
          // user not registerd with our server, so let's register it
          isLoading.value = false;
          RegisterController.emailController.text = googleAccount.value!.user!.email!;
          RegisterController.nameController.text =
              googleAccount.value?.user?.displayName ?? '';
          RegisterController.passwordController.text = googleAccount.value!.user!.uid;
          RegisterController.confirmPasswordController.text =
              googleAccount.value!.user!.uid;

          Get.toNamed(Routes.REGISTER, arguments: {
            'title': 'One More Step!',
            'buttonTitle': "Let's Begin",
            'passwordRequired': false
          });
        } else {
          isLoading.value = false;
          Get.snackbar('Opps', 'check your credentials');
        }
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  // function for facebook signin
  Future<void> signInWithFacebook() async {
    isLoading.value = true;
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final User? user = userCredential.user;

        //userCredential.
        Logger().i({
          'email': user?.email,
          'name': user?.displayName,
          'verified': user?.emailVerified,
          'uid': user?.uid,
          'photo': user?.photoURL
        });

        // at first try to login with facebook credential
        final response = await Authentication.loginConnection(
            email: user?.email ?? user!.phoneNumber!, password: user!.uid);

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
          if (accountType == 'Buyer') {
            Get.offAllNamed(Routes.HOME_BUYER);
          } else {
            Get.offAllNamed(Routes.SELLER_HOME);
          }
        } else if (response.statusCode == 400) {
          // user not registerd with our server, so let's register it
          isLoading.value = false;
          RegisterController.emailController.text =
              user.email ?? user.phoneNumber ?? '';
          RegisterController.nameController.text = user.displayName ?? '';
          RegisterController.passwordController.text = user.uid;
          RegisterController.confirmPasswordController.text = user.uid;

          Get.toNamed(Routes.REGISTER, arguments: {
            'title': 'One More Step!',
            'buttonTitle': "Let's Begin",
            'passwordRequired': false
          });
        } else {
          isLoading.value = false;
          Get.snackbar('Opps', 'check your credentials');
        }

        // logger.d("Logged in as: ${user?.displayName}");
        Logger().i('Logged In ${user.displayName}');
        // return user;
      } else {
        // logger.d("Fb login failed. ${result.status}");
        Logger().i('Result  ${result.status}');
        // return null;
      }
    } catch (e) {
      // logger.d("Error logging in with Facebook: $e");
      Logger().i('Error  $e');
      // return null;
    }
  }

  // function for email & password signin
  Future<void> signInWithEmail() async {
    isLoading.value = true;
    Logger().i(
        {'email': emailController.text, 'password': passwordController.text});
    final response = await Authentication.loginConnection(
        email: emailController.text, password: passwordController.text);

    Logger().i({'Response:': response.body});

    try {
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
        if (accountType == 'Buyer') {
          Get.offAllNamed(Routes.HOME_BUYER);
        } else {
          Get.offAllNamed(Routes.SELLER_HOME);
        }
      } else if (response.statusCode == 400) {
        isLoading.value = false;
        Get.snackbar('Opps', response.body);
      } else {
        isLoading.value = false;
        Get.snackbar('Opps', 'check your credentials');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Opps', 'check your connection');
      Logger().e(e);
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
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController.text = LocalPreferences.getCurrentLoginInfo().email ?? '';
  }

  @override
  void onClose() {
    googleAccount.close();
    obsecure.close();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    isSeller.close();
    isBuyer.close();
    super.onClose();
  }
}
