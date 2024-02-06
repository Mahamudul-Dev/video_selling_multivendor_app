import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_selling_multivendor_app/app/components/rating_card.component.dart';
import 'package:video_selling_multivendor_app/app/data/utils/constants.dart';

import '../../../../components/loading_animation.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({Key? key}) : super(key: key);
  final String productId = Get.arguments['id'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.editModeOn.value
            ? const Text('Product Edit')
            : const SizedBox.shrink()),
        actions: [
          Obx(
            () => controller.editModeOn.value
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      Share.share('This product is awesome! Checkout the best deal! \n Link: $SHARE_BASE_URL${Routes.BUYER_PRODUCT_DETAILS}?productId=$productId');
                    },
                    icon: Icon(
                      Icons.share,
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
          ),
          Obx(() => controller.editModeOn.value
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () => controller.toggleEditMode(),
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),),),
          Obx(() => controller.editModeOn.value
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text(
                              'Are you sure?',
                            ),
                            titleTextStyle: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                            content: const Text(
                                'Your content will be delete from server & it could not be undone'),
                            contentTextStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                            actions: [
                              ElevatedButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .surfaceVariant)),
                                  child: Text(
                                    'Cancel',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant),
                                  )),
                              Obx(() => ElevatedButton(
                                  onPressed: () async {
                                    await controller
                                        .deleteVideo(productId)
                                        .then((value) async {
                                      Navigator.pop(ctx);
                                      await Future.delayed(
                                          const Duration(milliseconds: 50),
                                          () => Navigator.pop(context));
                                    });
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Theme.of(context)
                                              .colorScheme
                                              .errorContainer)),
                                  child: controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Text(
                                          'Delete',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onErrorContainer),
                                        )))
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onBackground,
                  ))),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? LoadingAnimation()
            : FutureBuilder(
                future: controller.getProductDetails(productId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          AspectRatio(
                              aspectRatio: 16.0 / 9.0,
                              child: CachedNetworkImage(
                                  imageUrl: snapshot.data?.thumbnail != "" ||
                                          snapshot.data?.thumbnail != "N/A"
                                      ? BASE_URL + snapshot.data!.thumbnail!
                                      : PLACEHOLDER_THUMBNAIL)),
                          const SizedBox(
                            height: 20,
                          ),
                          // product title

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Obx(() => TextField(
                                  enabled: controller.editModeOn.value,
                                  controller: controller.productTitleController,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  onChanged: (value) {
                                    controller.productTitleController.text =
                                        value;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Title',
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder()),
                                )),
                          ),

                          // product price

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Text(
                                    'Price',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Obx(() => TextField(
                                          enabled: controller.editModeOn.value,
                                          controller:
                                              controller.productPriceController,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          onChanged: (value) {
                                            controller.productPriceController
                                                .text = value;
                                          },
                                          textAlign: TextAlign.justify,
                                          decoration: const InputDecoration(
                                              labelText: 'Price',
                                              prefixIcon: Icon(
                                                  Icons.attach_money_sharp),
                                              border: OutlineInputBorder(),
                                              enabledBorder:
                                                  OutlineInputBorder(),
                                              errorBorder:
                                                  OutlineInputBorder()),
                                        )))
                              ],
                            ),
                          ),

                          // product description
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Obx(() => TextField(
                                  enabled: controller.editModeOn.value,
                                  controller:
                                      controller.productDescriptionController,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.justify,
                                  maxLines: 7,
                                  onChanged: (value) {
                                    controller.productDescriptionController
                                        .text = value;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Description',
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(),
                                      errorBorder: OutlineInputBorder()),
                                )),
                          ),

                          controller.editModeOn.value
                              ? const SizedBox(
                                  height: 15,
                                )
                              : const SizedBox.shrink(),
                          Obx(
                            () => controller.editModeOn.value
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    child: DropdownButtonFormField(
                                        decoration: const InputDecoration(
                                          focusedBorder: OutlineInputBorder(),
                                          border: OutlineInputBorder(),
                                          label: Text('Category'),
                                        ),
                                        value: controller.videoCategory.value,
                                        items: controller.allCategories
                                            .map((element) => DropdownMenuItem(
                                                  value: element,
                                                  child: Text(
                                                    element,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (value) =>
                                            controller.selectCategories(value)),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    child: TextField(
                                      enabled: controller.editModeOn.value,
                                      controller: TextEditingController(
                                          text: controller.videoCategory.value),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      textAlign: TextAlign.justify,
                                      decoration: const InputDecoration(
                                          labelText: 'Category',
                                          border: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(),
                                          errorBorder: OutlineInputBorder()),
                                    ),
                                  ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          // rating bar section
                          Obx(
                            () => controller.editModeOn.value
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Ratings & Reviews',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          Obx(
                            () => controller.editModeOn.value
                                ? const SizedBox.shrink()
                                : Row(
                                    children: [
                                      RatingBar.builder(
                                          initialRating: snapshot.data?.ratings
                                                  ?.toDouble() ??
                                              0.0,
                                          unratedColor: Colors.grey,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 30,
                                          ignoreGestures: true,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                          itemBuilder: (context, index) {
                                            return const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            );
                                          },
                                          onRatingUpdate: (value) {}),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${snapshot.data?.ratings ?? 0 / snapshot.data!.reviews!.length}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      )
                                    ],
                                  ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Obx(
                            () => controller.editModeOn.value
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: snapshot.data!.reviews!.isEmpty
                                        ? Center(
                                            child: Text(
                                              'No reviews found!',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          )
                                        : ListView.separated(
                                            shrinkWrap: true,
                                            itemCount: snapshot
                                                    .data?.reviews?.length ??
                                                0,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              if (index == 0) {
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    FutureBuilder(
                                                        future: controller
                                                            .getSingleProfile(
                                                                snapshot
                                                                    .data!
                                                                    .reviews![
                                                                        index]
                                                                    .user!),
                                                        builder: (context,
                                                            profileSnapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return RatingCard(
                                                                authorProfileImage:
                                                                    profileSnapshot
                                                                            .data
                                                                            ?.profilePic ??
                                                                        PLACEHOLDER_PHOTO,
                                                                authorName:
                                                                    profileSnapshot
                                                                            .data
                                                                            ?.name ??
                                                                        'Unknown',
                                                                ratingPoint: snapshot
                                                                        .data
                                                                        ?.reviews?[
                                                                            index]
                                                                        .rating
                                                                        ?.toDouble() ??
                                                                    0.0,
                                                                ratingMessage: snapshot
                                                                        .data
                                                                        ?.reviews?[
                                                                            index]
                                                                        .review ??
                                                                    '');
                                                          }

                                                          return Shimmer(
                                                            gradient:
                                                                LinearGradient(
                                                                    colors: [
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .outline,
                                                                  Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .surfaceVariant
                                                                ]),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.9,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(20),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondaryContainer,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                  ],
                                                );
                                              }
                                              return RatingCard(
                                                  authorProfileImage:
                                                      PLACEHOLDER_PHOTO,
                                                  authorName: snapshot
                                                          .data
                                                          ?.reviews?[index]
                                                          .user ??
                                                      'Unknown',
                                                  ratingPoint: snapshot
                                                          .data
                                                          ?.reviews?[index]
                                                          .rating
                                                          ?.toDouble() ??
                                                      0.0,
                                                  ratingMessage: snapshot
                                                          .data
                                                          ?.reviews?[index]
                                                          .review ??
                                                      '');
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const SizedBox(
                                                width: 10,
                                              );
                                            },
                                          ),
                                  ),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          LottieBuilder.asset(ERROR_ANIM),
                          Text(
                            'There was an error from server.\n We will fix it as soon as possible.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.red),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const LoadingAnimation();
                  }
                },
              ),
      ),
      bottomNavigationBar: Obx(
        () => controller.editModeOn.value
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                      child: ElevatedButton(
                        onPressed: () => controller.editModeOn.value =
                            !controller.editModeOn.value,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.surfaceVariant)),
                        child: Text(
                          'Cancel',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                      child: ElevatedButton(
                        onPressed: () => controller.updateProduct(productId),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context)
                                    .colorScheme
                                    .primaryContainer)),
                        child: Text(
                          'Update',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
