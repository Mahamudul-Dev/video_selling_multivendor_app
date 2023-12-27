import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/components/loading_animation.dart';

import '../../../../routes/app_pages.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: SafeArea(
            child: Obx(() => controller.isLoading.value
                ? const LoadingAnimation()
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Enter your email & password',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.emailController,
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      return 'Email is required';
                                    } else if (!controller
                                        .isEmailValid(value)) {
                                      return 'Please write correct email address';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      label: Text('Email',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(color: Colors.grey)),
                                      hintText: 'Type your email',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Obx(() => TextFormField(
                                      controller: controller.passwordController,
                                      obscureText: controller.obsecure.value,
                                      validator: (value) {
                                        if (value == null || value == '') {
                                          return 'Password is required';
                                        } else if (value.length < 6) {
                                          return 'Password must be at least 6 charecter';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        label: Text('Password',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium
                                                ?.copyWith(color: Colors.grey)),
                                        hintText: 'Type your password',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.grey),
                                        suffixIconColor: Theme.of(context).primaryColor,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              controller.obsecure.value =
                                                  !controller.obsecure.value;
                                            },
                                            icon: Obx(() => controller
                                                    .obsecure.value
                                                ? const Icon(
                                                    Icons.password_rounded)
                                                : const Icon(Icons
                                                    .remove_red_eye_rounded))),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.signInWithEmail();
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Don't have a account?",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(Routes.REGISTER, arguments: {'title':'Sign Up', 'buttonTitle':'Sign Up', 'passwordRequired': true}),
                              child: Text(
                                "Sign up",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 1,
                              width: 50,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "Sign In with",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                            Container(
                              height: 1,
                              width: 50,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialLoginButton('google'),
                            const SizedBox(width: 8),
                            _socialLoginButton('facebook'),
                            const SizedBox(width: 8),
                            _socialLoginButton('twitter')
                          ],
                        )
                      ],
                    ),
                  ))));
  }

  Widget _socialLoginButton(String provider) {
    switch (provider) {
      case 'google':
        return InkWell(
          onTap: () => controller.signInWithGoogle(),
          child: const Card(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(GOOGLE_LOGO),
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );

      case 'facebook':
        return InkWell(
          onTap: () => controller.signInWithFacebook(),
          child: Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.facebook,
                  size: 30,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          ),
        );

      case 'twitter':
        return InkWell(
          onTap: () {},
          child: Card(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.twitter,
                  size: 30,
                  color: Colors.blue.shade600,
                ),
              ),
            ),
          ),
        );
      default:
        return const InkWell(
          child: Card(),
        );
    }
  }
}
