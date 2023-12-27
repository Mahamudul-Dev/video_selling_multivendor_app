import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/username_change_sheet.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../components/loading_animation.dart';
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
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
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
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
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
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(),
                              label: Text(
                                'Display Name',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              hintText: 'Type your name',
                              hintStyle:
                                  Theme.of(context).textTheme.bodyMedium),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceVariant,
                      child: Center(
                        child: Icon(
                          Icons.alternate_email_rounded,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                    trailing: Obx(() => ElevatedButton(
                        onPressed: controller.isUserNameChanged.value
                            ? null
                            : () {
                                // To:Do Navigate to changed username screen
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return UsernameChangeSheet(
                                        onCheck: ()=> controller
                                            .checkUsernameAvailablity(),
                                        onUpdate: ()=> controller.updateUsername(),
                                        controller:
                                            controller.usernameController,
                                        updateButtonEnabled: true.obs,
                                      );
                                    });
                              },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(controller
                                    .isUserNameChanged.value
                                ? Theme.of(context).colorScheme.surfaceVariant
                                : Colors.amber.shade900)),
                        child: Text(
                          'Change',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white),
                        ))),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.surfaceVariant,
                      child: Center(
                        child: Icon(
                          Icons.email_rounded,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                    trailing: Obx(() => ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                controller.emailVerified.value
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .errorContainer)),
                        onPressed: () {
                          // TO DO: Navigate to OTP input screen.
                        },
                        child: Text(
                          controller.emailVerified.value
                              ? 'Verified'
                              : 'Unverified',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white),
                        ))),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Interests',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  TextField(
                    controller: controller.interestInputController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) => controller.onInterestAdd(),
                    decoration: InputDecoration(
                        suffix: ElevatedButton(
                          onPressed: () => controller.onInterestAdd(),
                          child: Text('Add',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        hintText: 'Type your interested topics',
                        hintStyle: Theme.of(context).textTheme.bodyMedium,
                        focusedBorder: const UnderlineInputBorder(),
                        enabledBorder: const UnderlineInputBorder()),
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
                                ),
                              ))
                          .toList()))
                ],
              )),
        floatingActionButton: Obx(() => controller.isUpdating.value
            ? const SizedBox.shrink()
            : FloatingActionButton.extended(
                onPressed: () => controller.updateProfile(),
                label: Text(
                  'Update',
                  style: Theme.of(context).textTheme.bodyLarge,
                ))));
  }
}
