import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../themes/app_colors.dart';
import '../../../buyer/components/loading_animation.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final String? pageTitle = Get.arguments['title'] ?? 'Sign Up';
  final String? actionButtonTitle = Get.arguments['buttonTitle'] ?? 'Sign Up';
  final bool? passwordRequired = Get.arguments['passwordRequired'] ?? true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: SECONDARY_APP_COLOR,
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
                              pageTitle!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: SECONDARY_APP_COLOR),
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
                              "Let's create a new account",
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
                                  controller: RegisterController.nameController,
                                  decoration: InputDecoration(
                                      label: Text('Name',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium
                                              ?.copyWith(color: Colors.grey)),
                                      hintText: 'Type your first name',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.grey)),
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      return 'Name is required';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller:
                                      RegisterController.emailController,
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
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                passwordRequired!
                                    ? Obx(() => TextFormField(
                                          obscureText:
                                              controller.obsecure.value,
                                          controller: RegisterController
                                              .passwordController,
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
                                                      ?.copyWith(
                                                          color: Colors.grey)),
                                              hintText: 'Type your password',
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                              suffixIcon: IconButton(
                                                  onPressed: () {
                                                    controller.obsecure.value =
                                                        !controller
                                                            .obsecure.value;
                                                  },
                                                  icon: Obx(() => controller
                                                          .obsecure.value
                                                      ? const Icon(Icons
                                                          .password_rounded)
                                                      : const Icon(Icons
                                                          .remove_red_eye_rounded))),
                                              suffixIconColor:
                                                  SECONDARY_APP_COLOR),
                                        ))
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
                                ),
                                passwordRequired!
                                    ? Obx(() => TextFormField(
                                          obscureText:
                                              controller.obsecure.value,
                                          validator: (value) {
                                            if (value == null || value == '') {
                                              return 'Confirm password is required';
                                            } else if (value !=
                                                RegisterController
                                                    .passwordController.text) {
                                              return 'Password is not correct';
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                              label: Text('Confirm',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                          color: Colors.grey)),
                                              hintText: 'Retype your password',
                                              hintStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.grey)),
                                        ))
                                    : const SizedBox.shrink()
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flex(
                          mainAxisAlignment: MainAxisAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                leading: Obx(() => Checkbox(
                                    activeColor: SECONDARY_APP_COLOR,
                                    value: controller.isSeller.value,
                                    onChanged: (value) =>
                                        controller.toggleSeller(value))),
                                title: Text(
                                  'I am a seller',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: SECONDARY_APP_COLOR,
                                          fontSize: 12),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ListTile(
                                leading: Obx(() => Checkbox(
                                    activeColor: SECONDARY_APP_COLOR,
                                    value: controller.isBuyer.value,
                                    onChanged: (value) =>
                                        controller.toggleBuyer(value))),
                                title: Text(
                                  'I am a buyer',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: SECONDARY_APP_COLOR,
                                          fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      SECONDARY_APP_COLOR)),
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.registerNewAccount();
                                }
                              },
                              child: Text(
                                actionButtonTitle!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        passwordRequired!
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Already have a account?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: SECONDARY_APP_COLOR),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Get.offAllNamed(Routes.LOGIN),
                                    child: Text(
                                      "Sign in",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: Colors.blueGrey),
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ))));
  }
}
