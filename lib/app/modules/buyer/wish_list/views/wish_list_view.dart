import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

import '../../../../components/loading_animation.dart';
import '../../../../components/video_card_tile.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/wish_list_controller.dart';

class WishListView extends GetView<WishListController> {
  const WishListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wishlist'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: controller.getWishlistProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(
                          EMPTY_BOX_ANIM,
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        Text(
                          'Your wishlist is empty!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }
                return Obx(() => ListView.builder(
                      itemBuilder: (context, index) {
                        return Dismissible(
                            key: UniqueKey(),
                            onDismissed: (direction) async {
                              bool? shouldDismiss =
                                  await _showConfirmationDialog(
                                      context: context,
                                      productId: controller.wishlistProducts[index].productId!);
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
                                      .wishlistProducts[index].title ??
                                  '',
                              thumbnail: controller.wishlistProducts
                                          [index].thumbnail !=
                                      null
                                  ? '$BASE_URL${controller.wishlistProducts[index].thumbnail}'
                                  : PLACEHOLDER_THUMBNAIL,
                              author: controller
                                  .wishlistProducts[index].author!,
                              price: controller
                                  .wishlistProducts[index].price
                                  .toString(),
                              views: 0,
                              onItemPressed: () => Get.toNamed(
                                  Routes.BUYER_PRODUCT_DETAILS,
                                  parameters: {
                                    'productId':
                                    controller.wishlistProducts[index].productId!
                                  }),
                              onAuthorPressed: () => Get.toNamed(
                                  Routes.AUTHOR_PROFILE,
                                  arguments: {
                                    'id': controller.wishlistProducts[index].author!.authorId
                                  }),
                            ));
                      },
                      itemCount: controller.wishlistProducts.length,
                    ));
              }

              if (snapshot.hasError) {
                Logger().e(snapshot.error);
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
                  controller.removeFromWishlist(productId);
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
