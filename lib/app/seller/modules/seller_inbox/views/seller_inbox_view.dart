import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/seller_inbox_controller.dart';

class SellerInboxView extends GetView<SellerInboxController> {
  const SellerInboxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SellerInboxView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SellerInboxView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
