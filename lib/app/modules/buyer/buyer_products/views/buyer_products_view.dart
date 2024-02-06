import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/product.model.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../data/utils/enums.dart';
import '../../../../routes/app_pages.dart';
import '../../../../components/shimmer_effect.dart';
import '../../../../components/video_card_tile.dart';
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
                if (snapshot.data!.isNotEmpty) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return VideoCardTile(
                          thumbnail: snapshot.data![index].thumbnail == 'N/A'
                              ? PLACEHOLDER_THUMBNAIL
                              : '$BASE_URL${snapshot.data![index].thumbnail}',
                          title: snapshot.data?[index].title ?? '',
                          author: snapshot.data![index].author!,
                          price: snapshot.data![index].price.toString(),
                          views: snapshot.data?[index].viewsCount ?? 0,
                          initialRating: snapshot.data?[index].ratings ?? 0,
                          onItemPressed: () => Get.toNamed(
                              Routes.BUYER_PRODUCT_DETAILS,
                              parameters: {'productId': snapshot.data![index].id!}),
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
                } else {
                  return Center(
                    child: Text(
                      'No product for display',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
              }
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: ShimmerEffect.rectangular(
                        height: double.infinity,
                        width: MediaQuery.of(context).size.width * 0.2,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      title: ShimmerEffect.rectangular(
                        height: 10,
                        width: double.infinity,
                        shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      subtitle: SizedBox(
                        child: ShimmerEffect.rectangular(
                          height: 10,
                          width: MediaQuery.of(context).size.width * 0.5,
                          shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: 5);
            }));
  }
}
