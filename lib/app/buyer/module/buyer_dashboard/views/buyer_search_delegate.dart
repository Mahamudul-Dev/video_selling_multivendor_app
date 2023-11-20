import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pod_player/pod_player.dart';
import 'package:video_selling_multivendor_app/app/buyer/components/search_filter_dialog.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../components/loading_animation.dart';
import '../../../components/product_details_sheet.dart';
import '../../../components/shimmer_effect.dart';
import '../../../components/video_card_tile.dart';
import '../../buyer_cart/controllers/buyer_cart_controller.dart';
import '../controllers/buyer_search_controller.dart';

class BuyerSearchDelegate extends SearchDelegate<String> {
  final controller = Get.put<BuyerSearchController>(BuyerSearchController());

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            backgroundColor: SECONDARY_APP_COLOR,
            foregroundColor: Colors.white),
        textTheme: TextTheme(
            titleMedium: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            controller.clearFilter();
            query = '';
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, ''),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          color: Colors.white,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchView(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget searchView(BuildContext context) {
    return Column(
      children: [_buildActionBar(context), Expanded(child: _buildSearchView())],
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                flex: 10,
                child: Text(
                  'Search Result For "$query"',
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 2,
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return SearchFilterDialog(controller: controller);
                            });
                      },
                      icon: const Icon(
                        Icons.filter_alt,
                        color: SECONDARY_APP_COLOR,
                        size: 28,
                      )),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildSearchView() {
    return FutureBuilder<List<ProductModel>>(
        future: controller.searchVideo(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Obx(() => controller.filteredResult.value.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return VideoCardTile(
                        thumbnail:
                            controller.filteredResult.value[index].thumbnail ==
                                    'N/A'
                                ? PLACEHOLDER_THUMBNAIL
                                : controller.filteredResult.value[index]
                                        .thumbnail ??
                                    PLACEHOLDER_PHOTO,
                        title: controller.filteredResult.value[index].title ??
                            'Untitled',
                        author: () => controller.getProfile(
                            id: controller.filteredResult.value[index].author!),
                        price: controller.filteredResult.value[index].price ??
                            '00',
                        onItemPressed: () {
                          showBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return FutureBuilder<PodPlayerController>(
                                    future: controller.getPlayerController(
                                        controller.filteredResult.value[index]
                                            .previewUrl!),
                                    builder: (context, playerSnapshot) {
                                      if (playerSnapshot.hasData) {
                                        return ProductDetailsSheet(
                                          thumbnail: controller.filteredResult
                                              .value[index].thumbnail,
                                          trailerUrl: controller.filteredResult
                                              .value[index].previewUrl,
                                          title: controller.filteredResult
                                                  .value[index].title ??
                                              '',
                                          price: controller.filteredResult
                                                  .value[index].price ??
                                              '00.00',
                                          initialReting: double.parse(controller
                                              .filteredResult
                                              .value[index]
                                              .ratings
                                              .toString()),
                                          author: () => controller.getProfile(
                                              id: controller.filteredResult
                                                  .value[index].author!),
                                          productDescription: controller
                                                  .filteredResult
                                                  .value[index]
                                                  .description ??
                                              '',
                                          reviews: controller.filteredResult
                                                  .value[index].reviews ??
                                              [],
                                          playerController:
                                              playerSnapshot.data!,
                                          onAuthorPressed: () {},
                                          onCartPressed: () =>
                                              Get.find<BuyerCartController>()
                                                  .addToCart(controller
                                                      .filteredResult
                                                      .value[index]),
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
                    itemCount: controller.filteredResult.value.length)
                : controller.searchResult.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: DotLottieLoader.fromAsset(NO_SEARCH_RESULT_ANIM,
                            frameBuilder:
                                (BuildContext ctx, DotLottie? dotlottie) {
                          if (dotlottie != null) {
                            return Lottie.memory(
                                dotlottie.animations.values.single);
                          } else {
                            return Container();
                          }
                        }),
                      )
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          return VideoCardTile(
                            thumbnail: controller
                                        .searchResult[index].thumbnail ==
                                    'N/A'
                                ? PLACEHOLDER_THUMBNAIL
                                : controller.searchResult[index].thumbnail ??
                                    PLACEHOLDER_PHOTO,
                            title: controller.searchResult[index].title ??
                                'Untitled',
                            author: () => controller.getProfile(
                                id: controller.searchResult[index].author!),
                            price: controller.searchResult[index].price ?? '00',
                            onItemPressed: () {
                              showBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FutureBuilder<PodPlayerController>(
                                        future: controller.getPlayerController(
                                            controller.searchResult[index]
                                                .previewUrl!),
                                        builder: (context, playerSnapshot) {
                                          if (playerSnapshot.hasData) {
                                            return ProductDetailsSheet(
                                              thumbnail: controller
                                                  .searchResult[index]
                                                  .thumbnail,
                                              trailerUrl: controller
                                                  .searchResult[index]
                                                  .previewUrl,
                                              title: controller
                                                      .searchResult[index]
                                                      .title ??
                                                  '',
                                              price: controller
                                                      .searchResult[index]
                                                      .price ??
                                                  '00.00',
                                              initialReting: double.parse(
                                                  controller.searchResult[index]
                                                      .ratings
                                                      .toString()),
                                              author: () =>
                                                  controller.getProfile(
                                                      id: controller
                                                          .searchResult[index]
                                                          .author!),
                                              productDescription: controller
                                                      .searchResult[index]
                                                      .description ??
                                                  '',
                                              reviews: controller
                                                      .searchResult[index]
                                                      .reviews ??
                                                  [],
                                              playerController:
                                                  playerSnapshot.data!,
                                              onAuthorPressed: () {},
                                              onCartPressed: () => Get.find<
                                                      BuyerCartController>()
                                                  .addToCart(controller
                                                      .searchResult[index]),
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
                        itemCount: controller.searchResult.length));
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: ShimmerEffect.rectangular(
                    height: 15,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  subtitle: ShimmerEffect.rectangular(
                    height: 10,
                    width: MediaQuery.of(context).size.width * 0.5,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  leading: ShimmerEffect.rectangular(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.2,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: 8);
        });
  }
}
