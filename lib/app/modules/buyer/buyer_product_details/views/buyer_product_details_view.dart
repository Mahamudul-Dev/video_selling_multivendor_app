import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pod_player/pod_player.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../data/models/product.model.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../controllers/buyer_product_details_controller.dart';

class BuyerProductDetailsView extends GetView<BuyerProductDetailsController> {
  BuyerProductDetailsView({Key? key}) : super(key: key);
  final ProductModel product = Get.arguments['product'];

  @override
  Widget build(BuildContext context) {
    Logger().i({'productDetailes': product.toJson()});
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: () => Get.toNamed(Routes.CART),
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                  )),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: Obx(() =>
                          Get.find<BuyerCartController>().cartItems.isNotEmpty
                              ? Text(
                                  Get.find<BuyerCartController>()
                                      .cartItems
                                      .length
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                )
                              : Text(
                                  '0',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,
                                ))),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          // product image & preveiw

          FutureBuilder<PodPlayerController>(
              future: controller.getPlayerController(
                  product.previewUrl!, product.id!),
              builder: (context, playerSnapshot) {
                if (playerSnapshot.data != null) {
                  return PodVideoPlayer(
                    controller: playerSnapshot.data!,
                    videoThumbnail: DecorationImage(
                      image: CachedNetworkImageProvider(
                        product.thumbnail != '' || product.thumbnail != null ? BASE_URL+product.thumbnail! : PLACEHOLDER_THUMBNAIL,
                      ),
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 360,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Error while loading video',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  );
                }
              }),

          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                // product title
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          product.title ?? 'No Title',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                // author details
                ListTile(
                  onTap: () => Get.toNamed(Routes.AUTHOR_PROFILE, arguments: {
                    'id': product.author!.authorId
                  }), // TO:DO: navigate to cretor profile
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        product.author?.profilePic == 'N/A'
                            ? PLACEHOLDER_PHOTO
                            : product.author?.profilePic ?? PLACEHOLDER_PHOTO),
                  ),
                  title: Text(
                    product.author?.name ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        product.author?.country ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                      Text(
                        'Total videos: ${product.author?.totalVideos}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                      )
                    ],
                  ),
                  trailing: ElevatedButton.icon(
                    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.surfaceVariant)),
                      onPressed:
                          () => Get.toNamed(Routes.MESSAGE, arguments: {'userId': product.author?.authorId}),
                      icon: Icon(
                        CupertinoIcons.mail,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      label: Text(
                        'Contact Me',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                      )),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => controller.wishlistLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                ))
                            : IconButton(
                                onPressed: () => controller.addWishlist(
                                    product.id!, context),
                                icon: Obx(() => Icon(
                                      controller.isWishlist.value
                                          ? Icons.label_rounded
                                          : Icons.label_outline_rounded,
                                      size: 25,
                                    )))),
                        Text(
                          'Wishlist',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall,
                        )
                      ],
                    ),
                    Container(
                      width: 0.5,
                      height: 45,
                      color: Theme.of(context).dividerColor,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(() => controller.favLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                ))
                            : IconButton(
                                onPressed: () => controller.addFavorite(
                                    product.id!, context),
                                icon: Obx(() => Icon(
                                      controller.isFavourite.value
                                          ? FontAwesomeIcons.heartCircleCheck
                                          : FontAwesomeIcons.heart,
                                      size: 20,
                                    )))),
                        Text(
                          'Favorite',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall,
                        )
                      ],
                    )
                  ],
                ),

                // product description
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Description',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          product.description ?? '',
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                // rating bar section
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Ratings & Reviews',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    RatingBar.builder(
                        initialRating: product.ratings?.toDouble() ?? 0.0,
                        unratedColor: Colors.grey,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        ignoreGestures: true,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 5.0),
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
                      '${product.ratings ?? 0 / product.reviews!.length}',
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
              ],
            ),
          )),

          ListTile(
            title: Text('Video Price',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium),
            subtitle: Text(
              '\$${product.price}',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),
            trailing: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.secondaryContainer)
              ),
                onPressed: () {
                  if (controller.isCartAdded.value) {
                    Get.snackbar('Opps!', 'Product already in cart');
                  } else {
                    Get.find<BuyerCartController>().addToCart(product);
                  }
                },
                icon: Icon(
                  CupertinoIcons.cart_fill_badge_plus,
                  size: 25,
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                label: Obx(() =>
                    Get.find<BuyerCartController>().cartLoading.value
                        ? LoadingAnimationWidget.horizontalRotatingDots(
                            color: Theme.of(context).colorScheme.onSecondaryContainer, size: 20)
                        : Obx(() => Text(
                              controller.isCartAdded.value
                                  ? 'Already Added'
                                  : 'Add to cart',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer)
                            )))),
          ),
        ],
      ),
    );
  }
}
