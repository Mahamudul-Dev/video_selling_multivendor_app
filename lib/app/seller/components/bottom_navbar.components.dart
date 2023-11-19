import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../modules/seller_home/controllers/seller_home_controller.dart';

class BottomNavbar extends GetView<SellerHomeController> {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedBottomNavigationBar(
          icons: const <IconData>[
            Icons.dashboard,
            Icons.wallet,
            Icons.mail_rounded,
            Icons.account_circle_rounded
          ],
          activeIndex: controller.currentPage.value,
          gapLocation: GapLocation.center,
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          backgroundColor: SECONDARY_APP_COLOR,
          height: 50,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            controller.currentPage.value = index;
          }),
      //other params
    );
  }
}
