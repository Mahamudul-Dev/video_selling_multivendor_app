import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../models/product.model.dart';
import '../../../../models/product_filter.enum.dart';
import '../../../../utils/constants.dart';
import '../../../components/loading_animation.dart';
import '../../../components/product_details_sheet.dart';
import '../../../components/shimmer_effect.dart';
import '../../../components/video_card_tile.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../controllers/buyer_products_controller.dart';

class BuyerProductsView extends GetView<BuyerProductsController> {
  BuyerProductsView({Key? key}) : super(key: key);
  final String title = Get.arguments['title'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
        ),
        body: FutureBuilder<List<ProductModel>>(
            future: controller.getFilterdVideo(title == 'Top Sale'
                ? Filter.SALEH2L
                : title == 'Top Rated'
                    ? Filter.RATINGH2L
                    : Filter.SALEH2L),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      return VideoCardTile(
                        thumbnail: snapshot.data![index].thumbnail == 'N/A'
                            ? PLACEHOLDER_THUMBNAIL
                            : snapshot.data![index].thumbnail ??
                                PLACEHOLDER_PHOTO,
                        title: snapshot.data![index].title ?? '',
                        author: () => controller.getProfile(
                            id: snapshot.data![index].author!),
                        price: snapshot.data![index].price ?? '00',
                        onItemPressed: () {
                          showBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return FutureBuilder<PodPlayerController>(
                                    future: controller.getPlayerController(
                                        snapshot.data![index].previewUrl!),
                                    builder: (context, playerSnapshot) {
                                      if (playerSnapshot.hasData) {
                                        return ProductDetailsSheet(
                                          thumbnail:
                                              snapshot.data![index].thumbnail,
                                          trailerUrl:
                                              snapshot.data![index].previewUrl,
                                          title:
                                              snapshot.data![index].title ?? '',
                                          price: snapshot.data![index].price ??
                                              '00.00',
                                          author: () => controller.getProfile(
                                              id: snapshot
                                                  .data![index].author!),
                                          initialReting: double.parse(snapshot
                                              .data![index].ratings
                                              .toString()),
                                          productDescription: snapshot
                                                  .data![index].description ??
                                              '',
                                          playerController:
                                              playerSnapshot.data!,
                                          reviews:
                                              snapshot.data![index].reviews ??
                                                  [],
                                          onAuthorPressed: () {},
                                          onCartPressed: () =>
                                              Get.find<BuyerCartController>()
                                                  .addToCart(
                                                      snapshot.data![index]),
                                          onContactPressed: () {},
                                        );
                                      }

                                      return const LoadingAnimation();
                                    });
                              });
                        },
                        onAuthorPressed: () {},
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        thickness: 0.3,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                    itemCount: snapshot.data!.length);
              }
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ShimmerEffect.rectangular(
                      height: MediaQuery.of(context).size.width * 0.5,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: 5);
            }));
  }
}
