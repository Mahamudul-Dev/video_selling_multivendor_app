import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pod_player/pod_player.dart';
import 'package:video_selling_multivendor_app/app/buyer/components/search_filter_dialog.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../data/models/product.model.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../routes/app_pages.dart';
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
                ? Column(
                  children: [
                    Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8),
                                child: Text(
                                  'Creators',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: SECONDARY_APP_COLOR),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8),
                                child: Text(
                                  'See all',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: SECONDARY_APP_COLOR),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 80,
                            // color: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            child: _buildCreatorList(controller.filteredCreatorList),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: Text(
                              'Products',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: SECONDARY_APP_COLOR),
                            ),
                          ),
                    Expanded(
                      child: ListView.separated(
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
                              views: int.parse(
                                  controller.filteredResult[index].viewsCount ?? '0'),
                              initialRating:
                                  controller.filteredResult[index].ratings ?? 0,
                              author: controller.filteredResult.value[index].author!,
                              price: controller.filteredResult.value[index].price
                                  .toString(),
                              onItemPressed: () => Get.toNamed(
                                  Routes.BUYER_PRODUCT_DETAILS,
                                  arguments: {
                                    'product': controller.filteredResult.value[index]
                                  }),
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
                          itemCount: controller.filteredResult.value.length),
                    ),
                  ],
                )
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8),
                                child: Text(
                                  'Creators',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: SECONDARY_APP_COLOR),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8),
                                child: Text(
                                  'See all',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: SECONDARY_APP_COLOR),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 80,
                            // color: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            child: _buildCreatorList(controller.creatorList),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: Text(
                              'Products',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: SECONDARY_APP_COLOR),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return VideoCardTile(
                                    thumbnail: controller.searchResult[index]
                                                .thumbnail ==
                                            'N/A'
                                        ? PLACEHOLDER_THUMBNAIL
                                        : '$BASE_URL${controller.searchResult[index].thumbnail}',
                                    title:
                                        controller.searchResult[index].title ??
                                            'Untitled',
                                    author:
                                        controller.searchResult[index].author!,
                                    views: int.parse(controller
                                            .searchResult[index].viewsCount ??
                                        '0'),
                                    initialRating: controller
                                            .searchResult[index].ratings ??
                                        0,
                                    price: controller.searchResult[index].price
                                        .toString(),
                                    onItemPressed: () => Get.toNamed(
                                        Routes.BUYER_PRODUCT_DETAILS,
                                        arguments: {
                                          'product':
                                              controller.searchResult[index]
                                        }),
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
                                itemCount: controller.searchResult.length),
                          ),
                        ],
                      ));
          }
          return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: ShimmerEffect.rectangular(
                    height: 15,
                    width: double.infinity,
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

  Widget _buildCreatorList(List<Author> creatorList) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(
                    creatorList[index].profilePic == null ||
                            creatorList[index].profilePic == 'N/A'
                        ? PLACEHOLDER_PHOTO
                        : creatorList[index].profilePic!),
              ),
              const SizedBox(height: 3,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  creatorList[index].name ?? 'Unknown',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 14, color: SECONDARY_APP_COLOR),
                ),
              )
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
        itemCount: creatorList.length);
  }
}
