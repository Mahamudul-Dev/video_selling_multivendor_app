import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/seller_notification_controller.dart';

class SellerNotificationView extends GetView<SellerNotificationController> {
  const SellerNotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SellerNotificationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SellerNotificationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
