import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
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
        body: ListView(
          padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            TopProfileComponent(
              name: 'Michel Janson',
              subTitle: 'Mobile App Developer',
              subscriberCount: controller.formatNumber(152587878787),
              totalVideosCount: controller.formatNumber(500),
            ),
            GraphMonitor(
              monitorTitle: 'Earnings in last week',
              salesData: controller.yourWeeklySalesData,
              xAxisLabels: controller.yourXAxisLabels,
              yAxisLabels: controller.yourYAxisLabels,
            ),
          ],
        ));
  }
}
