import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:video_selling_multivendor_app/app/data/utils/asset_maneger.dart';

import '../controllers/create_product_controller.dart';

class ProductUploading extends GetView<CreateProductController> {
  const ProductUploading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => controller.videoThumbnailPath.value != ''
            ? ClipRRect(borderRadius: BorderRadius.circular(18), child: Image(image: FileImage(File(controller.videoThumbnailPath.value)), width: MediaQuery.of(context).size.width * 0.8, fit: BoxFit.cover))
            : ClipRRect(borderRadius: BorderRadius.circular(18), child: CachedNetworkImage(imageUrl: PLACEHOLDER_THUMBNAIL, width: MediaQuery.of(context).size.width * 0.8, fit: BoxFit.cover,))),
        const SizedBox(height: 20,),
        Obx(() => Container(
            width: double.infinity,
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: LiquidLinearProgressIndicator(
              value: controller.progress.value.toDouble() / 100,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation(Colors.cyan),
              borderColor: Colors.cyan,
              borderWidth: 1.0,
              borderRadius: 10,
              center: Text(
                '${controller.progress.value}%',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(color: controller.progress.value < 48 ? Colors.cyan :  Colors.white)
              ),
            ),
          ),),
        Obx(() => Text(
              controller.status.value,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white),
            ))
      ],
    );
  }
}
