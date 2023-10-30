import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:video_selling_multivendor_app/app/buyer/components/shimmer_effect.dart';
import 'package:video_selling_multivendor_app/themes/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/constants.dart';
import '../../../components/product_details_sheet.dart';
import '../../../components/video_card_full.dart';
import '../../../components/video_card_short.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../controllers/buyer_dashboard_controller.dart';

class BuyerDashboardView extends GetView<BuyerDashboardController> {
  const BuyerDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                _buildAppBar(context),
              ];
            },
            body: LiquidPullToRefresh(
              color: SECONDARY_APP_COLOR,
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
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.grey.shade800)),
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
            )),
        Stack(
          children: [
            IconButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.grey.shade800)),
                onPressed: () => Get.toNamed(Routes.CART),
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                )),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
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
                                    .bodySmall
                                    ?.copyWith(color: Colors.white),
                              )
                            : Text(
                                '0',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white),
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
        future: controller.initializeTrendingVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Obx(() => SizedBox(
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return VideoCardShort(
                          thumbnail:
                              controller.trendingVideos[index].thumbnail ??
                                  PLACEHOLDER_PHOTO,
                          title: controller.trendingVideos[index].title ?? '',
                          author: () => controller.getProfile(
                              id: controller.trendingVideos[index].author!),
                          price: controller.trendingVideos[index].price ?? '00',
                          // onCartPressed: () {
                          //   Get.find<BuyerCartController>()
                          //       .addToCart(controller.trendingVideos[index]);
                          // },
                          onItemPressed: () {
                            showBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return ProductDetailsSheet(
                                    thumbnail: controller
                                        .trendingVideos[index].thumbnail,
                                    trailerUrl: controller
                                        .trendingVideos[index].previewUrl,
                                    title: controller
                                            .trendingVideos[index].title ??
                                        '',
                                    price: controller
                                            .trendingVideos[index].price ??
                                        '00.00',
                                    author: () => controller.getProfile(
                                        id: controller
                                            .trendingVideos[index].author!),
                                    productDescription: controller
                                            .trendingVideos[index]
                                            .description ??
                                        '',
                                    onAuthorPressed: () {},
                                    onCartPressed: () =>
                                        Get.find<BuyerCartController>()
                                            .addToCart(controller
                                                .trendingVideos[index]),
                                    onContactPressed: () {},
                                  );
                                });
                          },
                          onAuthorPressed: () {},
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15.0,
                          ),
                      itemCount: controller.trendingVideos.length),
                )); //controller.trendingVideos.length));
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
        future: controller.initializeTrendingVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Obx(() => SizedBox(
                  height: MediaQuery.of(context).size.width * 0.5,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return VideoCardShort(
                          thumbnail:
                              controller.trendingVideos[index].thumbnail ??
                                  PLACEHOLDER_PHOTO,
                          title: controller.trendingVideos[index].title ?? '',
                          author: () => controller.getProfile(
                              id: controller.trendingVideos[index].author!),
                          price: controller.trendingVideos[index].price ?? '00',
                          // onCartPressed: () {
                          //   Get.find<BuyerCartController>()
                          //       .addToCart(controller.trendingVideos[index]);
                          // },
                          onItemPressed: () {
                            showBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return ProductDetailsSheet(
                                    thumbnail: controller
                                        .trendingVideos[index].thumbnail,
                                    trailerUrl: controller
                                        .trendingVideos[index].previewUrl,
                                    title: controller
                                            .trendingVideos[index].title ??
                                        '',
                                    price: controller
                                            .trendingVideos[index].price ??
                                        '00.00',
                                    author: () => controller.getProfile(
                                        id: controller
                                            .trendingVideos[index].author!),
                                    productDescription: controller
                                            .trendingVideos[index]
                                            .description ??
                                        '',
                                    onAuthorPressed: () {},
                                    onCartPressed: () =>
                                        Get.find<BuyerCartController>()
                                            .addToCart(controller
                                                .trendingVideos[index]),
                                    onContactPressed: () {},
                                  );
                                });
                          },
                          onAuthorPressed: () {},
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 15.0,
                          ),
                      itemCount: controller.trendingVideos.length),
                )); //controller.trendingVideos.length));
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
        future: controller.initializeTrendingVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Obx(() => SliverList.separated(
                  itemCount: controller.trendingVideos.length,
                  itemBuilder: (context, index) {
                    return VideoCardFull(
                      thumbnail: controller.trendingVideos[index].thumbnail ??
                          PLACEHOLDER_PHOTO,
                      title: controller.trendingVideos[index].title ?? '',
                      author: () => controller.getProfile(
                          id: controller.trendingVideos[index].author!),
                      price: controller.trendingVideos[index].price ?? '00',
                      onCartPressed: () {
                        Get.find<BuyerCartController>()
                            .addToCart(controller.trendingVideos[index]);
                      },
                      onItemPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ProductDetailsSheet(
                                thumbnail:
                                    controller.trendingVideos[index].thumbnail,
                                trailerUrl:
                                    controller.trendingVideos[index].previewUrl,
                                title: controller.trendingVideos[index].title ??
                                    '',
                                price: controller.trendingVideos[index].price ??
                                    '00.00',
                                author: () => controller.getProfile(
                                    id: controller
                                        .trendingVideos[index].author!),
                                productDescription: controller
                                        .trendingVideos[index].description ??
                                    '',
                                onAuthorPressed: () {},
                                onCartPressed: () =>
                                    Get.find<BuyerCartController>().addToCart(
                                        controller.trendingVideos[index]),
                                onContactPressed: () {},
                              );
                            });
                      },
                      onAuthorPressed: () {},
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20.0,
                  ),
                )); //controller.trendingVideos.length));
          }

          return SliverList.separated(
              itemBuilder: (context, index) {
                return ShimmerEffect.rectangular(
                  height: MediaQuery.of(context).size.width * 0.5,
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
