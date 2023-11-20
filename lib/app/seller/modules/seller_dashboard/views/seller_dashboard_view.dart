import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/utils/constants.dart';
import '../../../components/expansion_product_tile.component.dart';
import '../../../components/graph_monitor.component.dart';
import '../../../components/top_profile.component.dart';
import '../controllers/seller_dashboard_controller.dart';

class SellerDashboardView extends GetView<SellerDashboardController> {
  const SellerDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DARK_ASH,
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: TopProfileComponent(
                    name: 'Michel Janson',
                    subTitle: 'Mobile App Developer',
                    subscriberCount: controller.formatNumber(152587878787),
                    totalVideosCount: controller.formatNumber(500),
                  ),
                ),
              ];
            },
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 320,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: GraphMonitor(
                            monitorTitle: 'Sales in 7 days',
                            monitorSubTitle: 'Top Sale',
                            salesData: controller.weeklySalesData,
                            xAxisLabels: controller.yourXAxisLabels,
                            yAxisDataType: 'dollar',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: GraphMonitor(
                            monitorTitle: 'Clicks in 7 days',
                            monitorSubTitle: 'Top Click',
                            salesData: controller.weeklyClicksData,
                            xAxisLabels: controller.yourXAxisLabels,
                            yAxisDataType: '',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 15,  bottom: 0),
                    child: Row(
                      children: [
                        Text('Content', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),)
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: ExpansionProductTile(productName: 'This is a title', productThumbnail: PLACEHOLDER_THUMBNAIL, duration: '5 Min 34 Sec', totalClicks: controller.formatNumber(45000), totalSaleTime: controller.formatNumber(32000), totalEarning: controller.formatNumber(4992000), category: 'Programming')
                ),

                 SliverToBoxAdapter(
                  child: ExpansionProductTile(productName: 'This is a title', productThumbnail: PLACEHOLDER_THUMBNAIL, duration: '5 Min 34 Sec', totalClicks: controller.formatNumber(45000), totalSaleTime: controller.formatNumber(32000), totalEarning: controller.formatNumber(4992000), category: 'Programming')
                ),


                 SliverToBoxAdapter(
                  child: ExpansionProductTile(productName: 'This is a title', productThumbnail: PLACEHOLDER_THUMBNAIL, duration: '5 Min 34 Sec', totalClicks: controller.formatNumber(45000), totalSaleTime: controller.formatNumber(32000), totalEarning: controller.formatNumber(4992000), category: 'Programming')
                )
              ],
            ))
        
        );
  }
}
