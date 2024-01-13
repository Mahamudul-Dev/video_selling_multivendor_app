import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({Key? key}) : super(key: key);
  final String productId = Get.arguments['id'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share, color: Theme.of(context).colorScheme.onBackground,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.onBackground,))
        ],
      ),
      body: ListView(
        
      )
    );
  }
}
