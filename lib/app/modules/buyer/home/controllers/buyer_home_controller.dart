import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../../../services/socket_service.dart';
import '../../../global/inbox/views/inbox_view.dart';
import '../../../global/notification/views/notification_view.dart';
import '../../resource.injection.dart';
import '../../buyer_dashboard/views/buyer_dashboard_view.dart';
import '../../buyer_profile/views/buyer_profile_view.dart';

class HomeControllerBuyer extends GetxController {
  RxInt currentPage = 0.obs;

  final List<Widget> pages = [
    const BuyerDashboardView(),
    const InboxView(),
    const NotificationView(),
    const BuyerProfileView()
  ];


  @override
  void onInit() {
    SocketService.initializeSocket();
    super.onInit();
  }

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
