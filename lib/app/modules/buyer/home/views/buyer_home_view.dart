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
        BottomNavigationBarItem(icon: Icon(Icons.notifications, color: Theme.of(context).colorScheme.secondary), activeIcon: Icon(Icons.notifications, color: Theme.of(context).colorScheme.primary,), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle, color: Theme.of(context).colorScheme.secondary), activeIcon: Icon(Icons.account_circle, color: Theme.of(context).colorScheme.primary,), label: 'Profile'),
      ]))
      
      // Container(
      //   color: Theme.of(context).primaryColor,
      //   padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      //   child: GNav(
      //       color: Theme.of(context).disabledColor,
      //       activeColor: Theme.of(context).indicatorColor,
      //       backgroundColor: Theme.of(context).primaryColor,
      //       tabBackgroundColor: Theme.of(context).hoverColor,
      //       padding: const EdgeInsets.all(10),
      //       gap: 8,
      //       onTabChange: (index) {
      //         controller.currentPage.value = index;
      //       },
      //       tabs: const [
      //         GButton(
      //           icon: Icons.home,
      //           text: 'Home',
      //         ),
      //         GButton(
      //           icon: Icons.message,
      //           text: 'Chats',
      //         ),
      //         GButton(
      //           icon: Icons.notifications,
      //           text: 'Notify',
      //         ),
      //         GButton(
      //           icon: Icons.account_circle,
      //           text: 'Profile',
      //         )
      //       ]),
      // ),
    );
  }
}
