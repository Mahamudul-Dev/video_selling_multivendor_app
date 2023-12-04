import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pod_player/pod_player.dart';

import '../../../themes/app_colors.dart';
import '../../data/models/product.model.dart';
import '../../data/models/profile.model.dart';
import '../../data/utils/asset_maneger.dart';
import 'shimmer_effect.dart';

class ProductDetailsSheet extends StatelessWidget {
  const ProductDetailsSheet({
    Key? key,
    this.thumbnail,
    this.trailerUrl,
    required this.title,
    required this.price,
    required this.initialReting,
    required this.reviews,
    required this.author,
    required this.productDescription,
    required this.playerController,
    this.onAuthorPressed,
    this.onCartPressed,
    this.onContactPressed,
  }) : super(key: key);

  final String? thumbnail;
  final String? trailerUrl;
  final String title;
  final String price;
  final double initialReting;
  final List<Review?> reviews;
  final Future<Profile?> Function() author;
  final String productDescription;
  final PodPlayerController playerController;
  final void Function()? onAuthorPressed;
  final void Function()? onCartPressed;
  final void Function()? onContactPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          // product image & preveiw

          thumbnail != null
              ? PodVideoPlayer(
                  controller: playerController,
                  videoThumbnail: DecorationImage(
                    image: CachedNetworkImageProvider(
                      thumbnail!,
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              : PodVideoPlayer(
                  controller: playerController,
                  videoThumbnail: const DecorationImage(
                    image: CachedNetworkImageProvider(
                      PLACEHOLDER_THUMBNAIL,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),

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
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                // author details
                FutureBuilder(
                    future: author(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListTile(
                          onTap: onAuthorPressed,
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(
                                snapshot.data?.profilePic == 'N/A'
                                    ? PLACEHOLDER_PHOTO
                                    : snapshot.data?.profilePic ??
                                        PLACEHOLDER_PHOTO),
                          ),
                          title: Text(
                            snapshot.data?.name ?? '',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'USA',
                                //'${author.}, ${author.country}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.grey.shade800),
                              ),
                              Text(
                                'Total videos: ${snapshot.data?.totalVideos}',
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
                                  backgroundColor: MaterialStatePropertyAll(
                                      SECONDARY_APP_COLOR)),
                              onPressed: onContactPressed,
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
                        height: 50,
                        width: double.infinity,
                      );
                    }),
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
                          productDescription,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey.shade800),
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
                        initialRating: initialReting,
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
                      '${initialReting / reviews.length}',
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
              '\$$price',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: SECONDARY_APP_COLOR),
            ),
            trailing: ElevatedButton.icon(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(SECONDARY_APP_COLOR)),
                onPressed: onCartPressed,
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
      ),
    );
  }
}
