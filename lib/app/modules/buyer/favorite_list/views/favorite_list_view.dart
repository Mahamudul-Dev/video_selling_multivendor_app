// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../components/loading_animation.dart';
import '../../../../components/video_card_tile.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../controllers/favorite_list_controller.dart';

class FavoriteListView extends GetView<FavoriteListController> {
  const FavoriteListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourits'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: controller.getFavoriteProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Obx(() => ListView.builder(
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              bool? shouldDismiss =
                                  await _showConfirmationDialog(
                                      context: context,
                                      productId: 
                                          controller.favouriteProducts
                                              .value[index].productId!);
                              if (shouldDismiss ?? false) {
                                Navigator.of(context)
                                    .pop(); // Dismiss the widget
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Canceles'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                            background: Container(
                              color:
                                  Theme.of(context).colorScheme.errorContainer,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.delete_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                    ),
                                    Icon(
                                      Icons.delete_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onErrorContainer,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: VideoCardTile(
                              title: controller
                                      .favouriteProducts.value[index].title ??
                                  '',
                              thumbnail: controller.favouriteProducts
                                          .value[index].thumbnail !=
                                      null
                                  ? '$BASE_URL${controller.favouriteProducts.value[index].thumbnail}'
                                  : PLACEHOLDER_THUMBNAIL,
                              author: controller
                                  .favouriteProducts.value[index].author!,
                              price: controller
                                  .favouriteProducts.value[index].price
                                  .toString(),
                              views: 0,
                            ));
                      },
                      itemCount: controller.favouriteProducts.length,
                    ));
              }

              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      ERROR_ANIM,
                      repeat: false,
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Text(
                        'There was an error\nwe are fixing this issus as soon as possible. Please try again latter',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    )
                  ],
                );
              }

              return const LoadingAnimation();
            }));
  }

  Future<bool?> _showConfirmationDialog(
      {required BuildContext context, required String productId}) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(
            'Remove',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          content: Text(
            'Are you sure? This action will remove the product from your favourite list',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          contentPadding: const EdgeInsets.all(25),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.secondaryContainer)),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                )),
            ElevatedButton(
                onPressed: () {
                  controller.removeFromFavourite(productId);
                  Navigator.of(context).pop(true);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.errorContainer)),
                child: Text(
                  'Remove',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                ))
          ],
        );
      },
    );
  }
}
