import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:video_selling_multivendor_app/themes/app_colors.dart';

import '../../../../components/video_card_full.dart';
import '../../../../constants/utils.dart';
import '../controllers/buyer_dashboard_controller.dart';

class BuyerDashboardView extends GetView<BuyerDashboardController> {
  const BuyerDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidPullToRefresh(
            color: SECONDARY_APP_COLOR,
            onRefresh: controller.refrashPage,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return const VideoCardFull(
                      title: '10 Tips for dogs owner',
                      authorName: 'Jully Alece',
                      authorPhoto: PLACEHOLDER_PHOTO,
                      price: '5.00');
                },
                separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade50,
                    ),
                itemCount: 50)));
  }
}
