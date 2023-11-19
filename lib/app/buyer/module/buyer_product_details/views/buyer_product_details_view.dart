import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../models/product.model.dart';
import '../../../../models/profile.model.dart';
import '../../../../utils/constants.dart';
import '../../../components/loading_animation.dart';
import '../../../components/shimmer_effect.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../controllers/buyer_product_details_controller.dart';

class BuyerProductDetailsView extends GetView<BuyerProductDetailsController> {
  BuyerProductDetailsView({Key? key}) : super(key: key);
  final productId = Get.arguments['productId'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BuyerProductDetailsView'),
          centerTitle: true,
        ),
        body: FutureBuilder<ProductModel?>(
            future: controller.getProductDetails(productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      // product image & preveiw

                      FutureBuilder<PodPlayerController>(
                          future: controller
                              .getPlayerController(snapshot.data!.previewUrl!),
                          builder: (context, playerSnapshot) {
                            if (playerSnapshot.data != null) {
                              return PodVideoPlayer(
                                controller: playerSnapshot.data!,
                                videoThumbnail: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    snapshot.data?.thumbnail ??
                                        PLACEHOLDER_THUMBNAIL,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return Container(
                                height: 360,
                                width: MediaQuery.of(context).size.width,
                                decoration:
                                    const BoxDecoration(color: Colors.black),
                                child: Center(
                                  child: Text(
                                    'Error while loading video',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      snapshot.data?.title ?? 'No Title',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // author details
                            FutureBuilder<Profile?>(
                                future: controller.getProductAuthor(
                                    id: snapshot.data!.author!),
                                builder: (context, authorSnapshot) {
                                  if (authorSnapshot.hasData) {
                                    return ListTile(
                                      onTap:
                                          () {}, // TO:DO: navigate to cretor profile
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                authorSnapshot
                                                            .data?.profilePic ==
                                                        'N/A'
                                                    ? PLACEHOLDER_PHOTO
                                                    : authorSnapshot
                                                            .data?.profilePic ??
                                                        PLACEHOLDER_PHOTO),
                                      ),
                                      title: Text(
                                        authorSnapshot.data?.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            authorSnapshot.data?.country ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color:
                                                        Colors.grey.shade800),
                                          ),
                                          Text(
                                            'Total videos: ${authorSnapshot.data?.totalVideos}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: SECONDARY_APP_COLOR,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                          )
                                        ],
                                      ),
                                      trailing: ElevatedButton.icon(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      SECONDARY_APP_COLOR)),
                                          onPressed:
                                              () {}, //TO:DO: navigate chat screen with seller
                                          icon: const Icon(
                                            CupertinoIcons.mail,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          label: Text(
                                            'Contact Me',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(color: Colors.white),
                                          )),
                                    );
                                  }

                                  return const ShimmerEffect.rectangular(
                                      height: 50);
                                }),
                            // product description
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      'Description',
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

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      snapshot.data?.description ?? '',
                                      textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Colors.grey.shade800),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
                            Row(
                              children: [
                                RatingBar.builder(
                                    initialRating:
                                        snapshot.data?.ratings?.toDouble() ??
                                            0.0,
                                    unratedColor: Colors.grey,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 30,
                                    ignoreGestures: true,
                                    itemPadding: const EdgeInsets.symmetric(
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
                                  '${snapshot.data!.ratings ?? 0 / snapshot.data!.reviews!.length}',
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
                                .bodyMedium
                                ?.copyWith(color: Colors.grey.shade900)),
                        subtitle: Text(
                          '\$${snapshot.data?.price}',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: SECONDARY_APP_COLOR),
                        ),
                        trailing: ElevatedButton.icon(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    SECONDARY_APP_COLOR)),
                            onPressed: () => Get.find<BuyerCartController>()
                                .addToCart(snapshot.data),
                            icon: const Icon(
                              CupertinoIcons.cart_fill_badge_plus,
                              color: Colors.white,
                              size: 25,
                            ),
                            label: Text(
                              'Add to cart',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                      )
                    ],
                  );
                }
              }
              return const LoadingAnimation();
            }));
  }
}
