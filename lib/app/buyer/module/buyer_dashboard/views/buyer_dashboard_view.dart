import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../../../components/loading_animation.dart';
import '../../../../constants/utils.dart';
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
                SliverAppBar(
                  // expandedHeight: 100.0,
                  floating: false,
                  pinned: true,
                  title: const Text(APP_NAME),
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
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.grey.shade800)),
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
                                child: Obx(() => Get.find<BuyerCartController>()
                                        .cartItems
                                        .isNotEmpty
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
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Top Sale',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    _buildTopSaleList(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Top Rated',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    _buildTopRatedList(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You May Like',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _buildYouMayLikeList()
                  ],
                ),
              ),
            )));
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
                          authorName:
                              controller.trendingVideos[index].author?.name ??
                                  '',
                          authorPhoto: controller
                                  .trendingVideos[index].author?.profilePhoto ??
                              PLACEHOLDER_PHOTO,
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
                                    author: controller
                                        .trendingVideos[index].author!,
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

          return const LoadingAnimation();
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
                          authorName:
                              controller.trendingVideos[index].author?.name ??
                                  '',
                          authorPhoto: controller
                                  .trendingVideos[index].author?.profilePhoto ??
                              PLACEHOLDER_PHOTO,
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
                                    author: controller
                                        .trendingVideos[index].author!,
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

          return const LoadingAnimation();
        });
  }

  Widget _buildYouMayLikeList() {
    return FutureBuilder(
        future: controller.initializeTrendingVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Obx(() => ListView.separated(
                // controller: controller.scrollController,
                itemBuilder: (context, index) {
                  return VideoCardFull(
                    thumbnail: controller.trendingVideos[index].thumbnail ??
                        PLACEHOLDER_PHOTO,
                    title: controller.trendingVideos[index].title ?? '',
                    authorName:
                        controller.trendingVideos[index].author?.name ?? '',
                    authorPhoto:
                        controller.trendingVideos[index].author?.profilePhoto ??
                            PLACEHOLDER_PHOTO,
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
                              title:
                                  controller.trendingVideos[index].title ?? '',
                              price: controller.trendingVideos[index].price ??
                                  '00.00',
                              author: controller.trendingVideos[index].author!,
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
                      width: 15.0,
                    ),
                itemCount: controller.trendingVideos
                    .length)); //controller.trendingVideos.length));
          }

          return const LoadingAnimation();
        });
  }
}
