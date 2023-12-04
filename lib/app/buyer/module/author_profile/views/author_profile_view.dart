import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/loading_animation.dart';
import '../../../components/video_card_full.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../controllers/author_profile_controller.dart';

class AuthorProfileView extends GetView<AuthorProfileController> {
  AuthorProfileView({Key? key}) : super(key: key);
  final authorId = Get.arguments['id'];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getAuthorProfile(authorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar.medium(
                    title: Text(snapshot.data?.data?.first.name ?? 'Unknown'),
                    centerTitle: true,
                    bottom: AppBar(
                      leading: const SizedBox.shrink(),
                      leadingWidth: 0.0,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Total Videos: ${controller.formatNumber(snapshot.data?.data?.first.totalVideos ?? 0)}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Subscribers: ${controller.formatNumber(snapshot.data?.data?.first.creatorSubscriptionList?.length ?? 0)}',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () => controller.copyAuthorIdToClipboard(
                              context,
                              snapshot.data?.data?.first.userName ?? ''),
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(LIGHT_ASH)),
                          icon: const Icon(
                            Icons.copy_rounded,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      color: SECONDARY_APP_COLOR,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                              .data?.data?.first.profilePic !=
                                          'N/A'
                                      ? '$BASE_URL${snapshot.data?.data?.first.profilePic}'
                                      : PLACEHOLDER_PHOTO,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 25.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Username: ${snapshot.data?.data?.first.userName}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'From: ${snapshot.data?.data?.first.country}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 3.0,
                                    ),
                                    Text(
                                      'City: ${snapshot.data?.data?.first.city}',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Business Inquery: ${snapshot.data?.data?.first.email}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RatingBar.builder(
                                        initialRating: 4.5,
                                        unratedColor: Colors.grey,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20,
                                        ignoreGestures: true,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 2.0),
                                        itemBuilder: (context, index) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        },
                                        onRatingUpdate: (value) {}),
                                    Row(
                                      children: [
                                        Text(
                                          '4.5',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(color: Colors.amber),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Ratings',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(color: Colors.amber),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('About',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Colors.white)),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            snapshot.data?.data?.first.about != ''
                                ? snapshot.data!.data!.first.about!
                                : 'No Details Available',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Videos',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: SECONDARY_APP_COLOR),
                        ),
                      ),
                    ],
                  )),
                  FutureBuilder(
                      future: controller.getAuthorProducts(
                          snapshot.data!.data!.first.userName!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return _loadVideoList(snapshot.data!);
                        } else if (snapshot.data == null) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                'No Data Found!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: SECONDARY_APP_COLOR),
                              ),
                            ),
                          );
                        } else {
                          return const LoadingAnimation();
                        }
                      })
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: SECONDARY_APP_COLOR,
                  label: Row(
                    children: [
                      const Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Message',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.white),
                      )
                    ],
                  )),
            );
          }
          return const Scaffold(
            body: Center(
              child: LoadingAnimation(),
            ),
          );
        });
  }

  Widget _loadVideoList(List<ProductModel> products) {
    return SliverList.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return VideoCardFull(
          thumbnail: products[index].thumbnail != null
              ? BASE_URL + products[index].thumbnail!
              : PLACEHOLDER_PHOTO,
          title: products[index].title ?? '',
          author: products[index].author!,
          price: products[index].price.toString(),
          onCartPressed: () {
            Get.find<BuyerCartController>().addToCart(products[index]);
          },
          onItemPressed: () {
            Get.toNamed(Routes.BUYER_PRODUCT_DETAILS,
                arguments: {'product': products[index]});
          },
          onAuthorPressed: () {},
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 3.0);
      },
    );
  }
}
