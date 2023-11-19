import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_product_controller.dart';

class CreateProductView extends GetView<CreateProductController> {
  const CreateProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateProductView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreateProductView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
