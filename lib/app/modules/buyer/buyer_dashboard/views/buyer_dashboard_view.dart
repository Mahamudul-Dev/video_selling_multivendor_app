import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../components/shimmer_effect.dart';
import '../../../../components/video_card_full.dart';
import '../../../../components/video_card_short.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../controllers/buyer_dashboard_controller.dart';
import 'buyer_search_delegate.dart';

class BuyerDashboardView extends GetView<BuyerDashboardController> {
  const BuyerDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [_buildAppBar(context)];
            },
            body: LiquidPullToRefresh(
              color: Theme.of(context).primaryColor,
              onRefresh: controller.onRefrash,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Sale',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                              onPressed: () => Get.toNamed(
                                  Routes.BUYER_PRODUCTS,
                                  arguments: {'title': 'Top Sale'}),
                              child: Text(
                                'See All',
                                style: Theme.of(context).textTheme.labelMedium,
                              ))
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(child: _buildTopSaleList()),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Rated',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          TextButton(
                              onPressed: () => Get.toNamed(
                                  Routes.BUYER_PRODUCTS,
                                  arguments: {'title': 'Top Rated'}),
                              child: Text(
                                'See All',
                                style: Theme.of(context).textTheme.labelMedium,
                              ))
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(child: _buildTopRatedList()),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        'You May Like',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 5,
                      ),
                    ),
                    _buildYouMayLikeList()
                  ],
                ),
              ),
            )));
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      // expandedHeight: 100.0,
      floating: false,
      pinned: true,
      title: const Image(
        image: AssetImage('assets/images/logo.jpeg'),
        width: 140,
        fit: BoxFit.fitWidth,
      ),
      actions: [
        IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: BuyerSearchDelegate()),
            icon: const Icon(
              Icons.search_rounded,
            )),
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
    );
  }

  Widget _buildTopSaleList() {
    return FutureBuilder(
        future: controller.initializeTopSaleProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.width * 0.6,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return VideoCardShort(
                        thumbnail: snapshot.data![index].thumbnail != null
                            ? BASE_URL + snapshot.data![index].thumbnail!
                            : PLACEHOLDER_PHOTO,
                        title: snapshot.data![index].title ?? '',
                        author: snapshot.data![index].author!,
                        price: snapshot.data![index].price.toString(),
                        onItemPressed: () {
                          Get.toNamed(Routes.BUYER_PRODUCT_DETAILS,
                              parameters: {'productId': snapshot.data![index].id!});
                        },
                        onAuthorPressed: () =>
                            Get.toNamed(Routes.AUTHOR_PROFILE, arguments: {
                          'id': snapshot.data![index].author!.authorId
                        }),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 15.0,
                        ),
                    itemCount: snapshot.data!.length),
              ); //controller.trendingVideos.length));
            } else {
              return SizedBox(
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                      child: Text(
                    'No Products Found.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                  )));
            }
          }

          return SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ShimmerEffect.rectangular(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.4,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: 15.0,
                    ),
                itemCount: 5),
          );
        });
  }

  Widget _buildTopRatedList() {
    return FutureBuilder(
        future: controller.initializeTopRatedProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SizedBox(
                height: MediaQuery.of(context).size.width * 0.6,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return VideoCardShort(
                        thumbnail: snapshot.data![index].thumbnail != null
                            ? BASE_URL + snapshot.data![index].thumbnail!
                            : PLACEHOLDER_PHOTO,
                        title: snapshot.data![index].title ?? '',
                        author: snapshot.data![index].author!,
                        price: snapshot.data![index].price.toString(),
                        onItemPressed: () {
                          Get.toNamed(Routes.BUYER_PRODUCT_DETAILS,
                              parameters: {'productId': snapshot.data![index].id!});
                        },
                        onAuthorPressed: () =>
                            Get.toNamed(Routes.AUTHOR_PROFILE, arguments: {
                          'id': snapshot.data![index].author!.authorId
                        }),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 15.0,
                        ),
                    itemCount: snapshot.data!.length),
              ); //controller.trendingVideos.length));
            } else {
              return SizedBox(
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: Center(
                      child: Text(
                    'No Products Found.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                  )));
            }
          }

          return SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ShimmerEffect.rectangular(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: MediaQuery.of(context).size.width * 0.4,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      width: 15.0,
                    ),
                itemCount: 5),
          );
        });
  }

  Widget _buildYouMayLikeList() {
    return FutureBuilder(
        future: controller.initializeYouMayLikeProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return SliverList.separated(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return VideoCardFull(
                    thumbnail: snapshot.data![index].thumbnail != null
                        ? BASE_URL + snapshot.data![index].thumbnail!
                        : PLACEHOLDER_PHOTO,
                    title: snapshot.data![index].title ?? '',
                    author: snapshot.data![index].author!,
                    price: snapshot.data![index].price.toString(),
                    onCartPressed: () {
                      Get.find<BuyerCartController>()
                          .addToCart(snapshot.data![index]);
                    },
                    onItemPressed: () {
                      Get.toNamed(Routes.BUYER_PRODUCT_DETAILS,
                          parameters: {'productId': snapshot.data![index].id!});
                    },
                    onAuthorPressed: () => Get.toNamed(Routes.AUTHOR_PROFILE,
                        arguments: {'id': snapshot.data![index].author!.authorId}),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20.0,
                ),
              ); //controller.trendingVideos.length));
            } else {
              return SliverToBoxAdapter(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                        'No Products Found.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ))));
            }
          }

          return SliverList.separated(
              itemBuilder: (context, index) {
                return ShimmerEffect.rectangular(
                  height: MediaQuery.of(context).size.width * 0.5,
                  width: double.infinity,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                );
              },
              itemCount: 5,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              });
        });
  }
}
