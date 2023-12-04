import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';

import '../../../../../themes/app_colors.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/seller_inbox_controller.dart';

class SellerInboxView extends GetView<SellerInboxController> {
  const SellerInboxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DARK_ASH,
        appBar: AppBar(
          title: const Text('Inbox'),
          centerTitle: true,
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
                    ?.copyWith(color: Colors.white),
              ),
              subtitle: Text(
                'Hey are you here?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white60),
              ),
              trailing: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: SECONDARY_APP_COLOR,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  timeago.format(DateTime.now()),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
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
