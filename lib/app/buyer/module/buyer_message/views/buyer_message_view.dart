import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../constants/utils.dart';
import '../controllers/buyer_message_controller.dart';

class BuyerMessageView extends GetView<BuyerMessageController> {
  const BuyerMessageView({Key? key}) : super(key: key);
  // final sellerId = Get.arguments['sellerId'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BuyerMessageView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: Obx(() => ListView.builder(
                      reverse: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor:
                              controller.messages[index].senderId == '1234'
                                  ? const Color.fromARGB(255, 245, 251, 255)
                                  : Colors.white70,
                          leading: const CircleAvatar(
                            backgroundColor: Colors.white60,
                            backgroundImage:
                                CachedNetworkImageProvider(PLACEHOLDER_PHOTO),
                          ),
                          title: Text(
                            'Demo1',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(controller.messages[index].message,
                              style: Theme.of(context).textTheme.bodyMedium),
                        );
                      },
                      itemCount: controller.messages.length,
                    ))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      type: MaterialType.canvas,
                      color: Colors.white70,
                      elevation: 1,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: TextField(
                          controller: controller.messageTextController,
                          style: Theme.of(context).textTheme.labelMedium,
                          decoration: InputDecoration(
                              hintText: 'Write your query...',
                              border: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.bodyMedium),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  IconButton(
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                          backgroundColor:
                              MaterialStatePropertyAll(SECONDARY_APP_COLOR)),
                      onPressed: () => controller.sendMessage(),
                      icon: const Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          ],
        ));
  }
}
