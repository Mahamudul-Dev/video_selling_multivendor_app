import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../components/shimmer_effect.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../../components/expansion_product_tile.component.dart';
import '../../../../components/graph_monitor.component.dart';
import '../../../../components/top_profile.component.dart';
import '../../../../routes/app_pages.dart';
import '../../seller_home/controllers/seller_home_controller.dart';
import '../../seller_profile/controllers/seller_profile_controller.dart';
import '../controllers/seller_dashboard_controller.dart';

class SellerDashboardView extends GetView<SellerDashboardController> {
  const SellerDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                    child: FutureBuilder(
                        future: Get.find<SellerProfileController>().getSellerProfile(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return TopProfileComponent(
                              name: snapshot.data?.name ?? 'Unknown',
                              subTitle: snapshot.data?.email,
                              subscriberCount: controller.formatNumber(snapshot
                                      .data?.creatorSubscriptionList?.length ??
                                  0),
                              totalVideosCount: controller.formatNumber(
                                  snapshot.data?.totalVideos ?? 0),
                              onTap: (){
                                Get.find<SellerHomeController>().currentPage.value = 3;
                              },
                            );
                          }
                          return ListTile(
                            leading: const ShimmerEffect.circuller(
                                width: 50, height: 50),
                            title: ShimmerEffect.rectangular(
                                width: MediaQuery.of(context).size.width,
                                height: 18),
                            subtitle: SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: ShimmerEffect.rectangular(
                                  width: MediaQuery.of(context).size.width,
                                  height: 18),
                            ),
                          );
                        })),
              ];
            },
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // SliverToBoxAdapter(
                //   child: SizedBox(
                //     height: 320,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         SizedBox(
                //           width: MediaQuery.of(context).size.width * 0.9,
                //           child: GraphMonitor(
                //             monitorTitle: 'Sales in 7 days',
                //             monitorSubTitle: 'Top Sale',
                //             salesData: controller.weeklySalesData,
                //             xAxisLabels: controller.yourXAxisLabels,
                //             yAxisDataType: 'dollar',
                //           ),
                //         ),
                //         SizedBox(
                //           width: MediaQuery.of(context).size.width * 0.9,
                //           child: GraphMonitor(
                //             monitorTitle: 'Clicks in 7 days',
                //             monitorSubTitle: 'Top Click',
                //             salesData: controller.weeklyClicksData,
                //             xAxisLabels: controller.yourXAxisLabels,
                //             yAxisDataType: '',
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 0),
                    child: Row(
                      children: [
                        Text(
                          'Your Content',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge,
                        )
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                    future: controller.getSellerProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SliverList.builder(
                          itemBuilder: (context, index) {
                            return ExpansionProductTile(
                                productName:
                                    snapshot.data?[index].title ?? 'Unknown',
                                productThumbnail: snapshot.data?[index].thumbnail != "" ? '$BASE_URL${snapshot.data?[index].thumbnail}' : PLACEHOLDER_THUMBNAIL,
                                duration: controller.formatDuration(double.parse(snapshot.data?[index].duration ??
                                            "0")),
                                totalClicks: controller.formatNumber(
                                    snapshot.data?[index].viewsCount ?? 0),
                                totalSaleTime: controller.formatNumber(
                                    snapshot.data?[index].totalSales ?? 0),
                                totalEarning: controller.formatNumber(82173618),
                                category: snapshot.data?[index].category ?? '',
                                isActive: snapshot.data?[index].videoStatus == 'active' ? true : false,
                                onDetailsPressed: ()=> Get.toNamed(Routes.PRODUCT_DETAILS, arguments: {'id':snapshot.data?[index].id}),  
                              );
                          },
                          itemCount: snapshot.data?.length,
                        );
                      }

                      return SliverList.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const ShimmerEffect.rectangular(
                                width: 60, height: 40),
                            title: ShimmerEffect.rectangular(
                                width: MediaQuery.of(context).size.width,
                                height: 18),
                            subtitle: ShimmerEffect.rectangular(
                                width: MediaQuery.of(context).size.width,
                                height: 18),
                          );
                        },
                        itemCount: 3,
                      );
                    })
              ],
            )));
  }
}
