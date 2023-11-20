import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../components/loading_animation.dart';
import '../controllers/buyer_profile_controller.dart';

class BuyerProfileEditView extends GetView<BuyerProfileController> {
  const BuyerProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          centerTitle: true,
        ),
        body: Obx(() => controller.isUpdating.value
            ? const LoadingAnimation()
            : ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Obx(() => controller.pickedImage.value != null
                          ? CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: FileImage(
                                  File(controller.pickedImage.value!.path)),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () => controller.getImage(),
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color:
                                            Color.fromARGB(66, 255, 255, 255),
                                      ))),
                            )
                          : CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey.shade200,
                              backgroundImage: CachedNetworkImageProvider(
                                  controller.userProfileImageUrl.value == ''
                                      ? PLACEHOLDER_PHOTO
                                      : controller.userProfileImageUrl.value),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () => controller.getImage(),
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color:
                                            Color.fromARGB(66, 255, 255, 255),
                                      ))),
                            )),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: controller.displayNameController,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: SECONDARY_APP_COLOR),
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: SECONDARY_APP_COLOR)),
                              label: Text(
                                'Display Name',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(color: SECONDARY_APP_COLOR),
                              ),
                              hintText: 'Type your name',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: SECONDARY_APP_COLOR,
                      child: Center(
                        child: Icon(
                          Icons.alternate_email_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      'Username',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    subtitle: Obx(() => Text(
                          controller.username.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                    trailing: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.grey.shade200)),
                        onPressed: null,
                        child: Text(
                          'Change',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: SECONDARY_APP_COLOR),
                        )),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: SECONDARY_APP_COLOR,
                      child: Center(
                        child: Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      'Email',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    subtitle: Obx(() => Text(
                          controller.userEmail.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                    trailing: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green)),
                        onPressed: () {},
                        child: Text(
                          'Verified',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Interests',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: SECONDARY_APP_COLOR),
                  ),
                  TextField(
                    controller: controller.interestInputController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) => controller.onInterestAdd(),
                    decoration: InputDecoration(
                        suffix: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  SECONDARY_APP_COLOR)),
                          onPressed: () => controller.onInterestAdd(),
                          child: Text('Add',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white)),
                        ),
                        hintText: 'Type your interested topics',
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: SECONDARY_APP_COLOR)),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: SECONDARY_APP_COLOR))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => Wrap(
                      spacing: 5.0,
                      children: controller.interestTags
                          .map((element) => Chip(
                                onDeleted: () =>
                                    controller.onInterestRemove(element),
                                label: Text(element),
                                labelStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                avatar: const Icon(
                                  Icons.label,
                                  color: SECONDARY_APP_COLOR,
                                ),
                              ))
                          .toList()))
                ],
              )),
        floatingActionButton: Obx(() => controller.isUpdating.value
            ? const SizedBox.shrink()
            : FloatingActionButton.extended(
                onPressed: () => controller.updateProfile(),
                backgroundColor: SECONDARY_APP_COLOR,
                label: Text(
                  'Update',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ))));
  }
}
