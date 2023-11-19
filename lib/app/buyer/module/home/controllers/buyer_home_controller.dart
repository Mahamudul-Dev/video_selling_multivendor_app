import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../resource.injection.dart';
import '../../buyer_chat/views/buyer_chat_view.dart';
import '../../buyer_dashboard/views/buyer_dashboard_view.dart';
import '../../buyer_profile/views/buyer_profile_view.dart';

class HomeControllerBuyer extends GetxController {
  RxInt currentPage = 0.obs;

  final List<Widget> pages = [
    const BuyerDashboardView(),
    const BuyerChatView(),
    const BuyerProfileView()
  ];

  @override
  void onReady() async {
    await injectAllResources();
    super.onReady();
  }

  @override
  void onClose() {
    currentPage.close();
    super.onClose();
  }
}
