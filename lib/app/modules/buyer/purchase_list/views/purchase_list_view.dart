import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../components/loading_animation.dart';
import '../../../../components/video_card_tile.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/purchase_list_controller.dart';

class PurchaseListView extends GetView<PurchaseListController> {
  const PurchaseListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Purchase'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: controller.getPurchaseList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Obx(() => ListView.builder(
                itemBuilder: (context, index) {
                  return VideoCardTile(
                    title: controller.purchaseList[index].title ??
                        '',
                    thumbnail: controller.purchaseList
                        [index].thumbnail !=
                        null
                        ? '$BASE_URL${controller.purchaseList[index].thumbnail}'
                        : PLACEHOLDER_THUMBNAIL,
                    author: controller.purchaseList[index].author!,
                    price: controller.purchaseList[index].price.toString(),
                    views: 0,

                    onItemPressed: ()=> Get.toNamed(Routes.VIDEO_PLAYER, arguments: {'id': controller.purchaseList[index].productId}),
                    onAuthorPressed: ()=> Get.toNamed(Routes.AUTHOR_PROFILE, arguments: {'id':controller.purchaseList[index].author!.authorId}),
                  );
                },
                itemCount: controller.purchaseList.length,
              ));
            }

            if (snapshot.hasError) {
              print(snapshot.error);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    ERROR_ANIM,
                    repeat: false,
                    height: MediaQuery.of(context).size.width * 0.3,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Text(
                      'There was an error\nwe are fixing this issus as soon as possible. Please try again latter',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error),
                    ),
                  )
                ],
              );
            }

            return const LoadingAnimation();
          })
    );
  }
}
