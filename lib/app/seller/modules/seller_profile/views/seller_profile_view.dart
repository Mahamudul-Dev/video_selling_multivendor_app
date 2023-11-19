import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/seller_profile_controller.dart';

class SellerProfileView extends GetView<SellerProfileController> {
  const SellerProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SellerProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SellerProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
