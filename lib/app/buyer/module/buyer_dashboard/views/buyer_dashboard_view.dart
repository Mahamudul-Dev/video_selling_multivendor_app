import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:video_selling_multivendor_app/app/buyer/components/product_details_sheet.dart';
import 'package:video_selling_multivendor_app/themes/app_colors.dart';

import '../../../components/loading_animation.dart';
import '../../../components/video_card_full.dart';
import '../../../../constants/utils.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../controllers/buyer_dashboard_controller.dart';

class BuyerDashboardView extends GetView<BuyerDashboardController> {
  const BuyerDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidPullToRefresh(
            color: SECONDARY_APP_COLOR,
            onRefresh: controller.refrashPage,
            child: FutureBuilder(
                future: controller.initializeTrendingVideos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Obx(() => ListView.separated(
                        itemBuilder: (context, index) {
                          return VideoCardFull(
                            thumbnail:
                                controller.trendingVideos[index].thumbnail ??
                                    PLACEHOLDER_PHOTO,
                            title: controller.trendingVideos[index].title ?? '',
                            authorName:
                                controller.trendingVideos[index].author?.name ??
                                    '',
                            authorPhoto: controller.trendingVideos[index].author
                                    ?.profilePhoto ??
                                PLACEHOLDER_PHOTO,
                            price:
                                controller.trendingVideos[index].price ?? '00',
                            onCartPressed: () {
                              Get.find<BuyerCartController>()
                                  .addToCart(controller.trendingVideos[index]);
                            },
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
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.grey.shade50,
                            ),
                        itemCount: controller.trendingVideos.length));
                  }

                  return const LoadingAnimation();
                })));
  }
}
