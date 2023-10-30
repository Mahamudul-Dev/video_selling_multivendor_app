import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/buyer_chat_controller.dart';

class BuyerChatView extends GetView<BuyerChatController> {
  const BuyerChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () => Get.toNamed(Routes.BUYER_MESSAGE),
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(PLACEHOLDER_PHOTO),
              ),
              title: Text(
                'Demo User',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: SECONDARY_APP_COLOR),
              ),
              subtitle: Text(
                'Hey are you here?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade800),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(timeago.format(DateTime.now())),
              ),
            );
          },
          itemCount: 4,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              thickness: 0.4,
              indent: 20,
              endIndent: 20,
            );
          },
        ));
  }
}
