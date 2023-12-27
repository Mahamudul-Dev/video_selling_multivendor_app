import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscribed_creator_list_controller.dart';

class SubscribedCreatorListView
    extends GetView<SubscribedCreatorListController> {
  const SubscribedCreatorListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubscribedCreatorListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubscribedCreatorListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
