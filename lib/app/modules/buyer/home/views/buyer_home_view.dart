import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/buyer_home_controller.dart';

class HomeViewBuyer extends GetView<HomeControllerBuyer> {
  const HomeViewBuyer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.pages[controller.currentPage.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: controller.currentPage.value,
        onTap: (value)=> controller.currentPage.value = value,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        selectedIconTheme: Theme.of(context).iconTheme,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.secondary,), activeIcon: Icon(Icons.home_rounded, color: Theme.of(context).colorScheme.primary,), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.message_rounded, color: Theme.of(context).colorScheme.secondary,), activeIcon: Icon(Icons.message_rounded, color: Theme.of(context).colorScheme.primary,), label: 'Message'),
        BottomNavigationBarItem(icon: Icon(Icons.playlist_add_check, color: Theme.of(context).colorScheme.secondary), activeIcon: Icon(Icons.playlist_add_circle_rounded, color: Theme.of(context).colorScheme.primary,), label: 'My Content'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle, color: Theme.of(context).colorScheme.secondary), activeIcon: Icon(Icons.account_circle, color: Theme.of(context).colorScheme.primary,), label: 'Profile'),
      ]))
    );
  }
}
