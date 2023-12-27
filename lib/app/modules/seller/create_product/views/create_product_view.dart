import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/create_product_controller.dart';
import 'product_uploading_view.dart';

class CreateProductView extends GetView<CreateProductController> {
  const CreateProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return 
    Obx(() {
      if (controller.isUploading.value) {
        return const ProductUploading();
      } else {
        return Scaffold(
      appBar: AppBar(
        title: const Text('Publish Studio'),
        centerTitle: true
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: controller.mediaScrollController,
              children: [
                // trailer upload card
                
                Obx(() {
                  if (controller.trailerPath.value.isNotEmpty && controller.trailerThumbnail.value != null) {
                    return Image(image: FileImage(controller.trailerThumbnail.value!), width: MediaQuery.of(context).size.width,);
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () => controller.getTrailer(),
                                  icon: const Icon(
                                    Icons.upload,
                                  )),
                              Text(
                                'Upload your trailer \n(max: 2 min)',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),

                // main content upload card

                Obx(() {
                  if (controller.mainContentPath.value.isNotEmpty && controller.mainContentThumbnail.value != null) {
                    return Image(image: FileImage(controller.mainContentThumbnail.value!), width: MediaQuery.of(context).size.width,);
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () => controller.getMainContent(),
                                  icon: const Icon(
                                    Icons.upload
                                  )),
                              Text(
                                'Upload your main content \n(max: 1 GB)',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),


                // upload thumbnail for product
                Obx(() {
                  if (controller.productThumbnail.value != null) {
                    return Image(image: FileImage(controller.productThumbnail.value!), width: MediaQuery.of(context).size.width,);
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () => controller.getProductThumbnail(),
                                  icon: const Icon(
                                    Icons.upload
                                  )),
                              Text(
                                'Upload your product thumbnail',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => DropdownButtonFormField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                      ),
                      value: controller.videoCategory.value,
                      items: controller.allCategories
                          .map((element) => DropdownMenuItem(
                                value: element,
                                child: Text(
                                  element,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                              ))
                          .toList(),
                      onChanged: (value) => controller.selectCategories(value)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controller.priceController,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(),
                      border: const OutlineInputBorder(),
                      label: Text(
                        'Video Price',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium,
                      ),
                      hintText: 'Enter 0.0 for make your video free',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodySmall,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '\$',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controller.videoTitleController,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(),
                      border: const OutlineInputBorder(),
                      label: Text(
                        'Video Title',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controller.videoDescController,
                  maxLines: 8,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(),
                      border: const OutlineInputBorder(),
                      hintText: 'Describe about your content',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: controller.tagEditingFieldController,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(),
                      border: const OutlineInputBorder(),
                      hintStyle: Theme.of(context)
                          .textTheme
                          .labelMedium,
                      hintText: 'Add tags'),
                  onFieldSubmitted: (value) => controller.addTag(value),
                ),
                Obx(() => Wrap(
                    spacing: 5.0,
                    children: controller.videoTags
                        .map((element) => Chip(
                              onDeleted: () => controller.onTagRemove(element),
                              label: Text(element),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium,
                              avatar: const Icon(
                                Icons.label,
                              ),
                            ))
                        .toList()))
              ],
            )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => controller.publishVideo(),
          label: Text(
            'Publish',
            style: Theme.of(context)
                .textTheme
                .labelMedium,
          )),
    );
      }
    });
  }
}
