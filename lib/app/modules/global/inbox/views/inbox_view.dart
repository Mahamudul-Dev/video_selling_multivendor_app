import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../data/preferences/local_preferences.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/inbox_controller.dart';

class InboxView extends GetView<InboxController> {
  const InboxView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inbox'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: controller.getInbox(),
            builder: (context, snapshot) {
              return Obx(() => InboxController.chats.value.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset(
                            NO_CHAT_ANIM,
                            height: MediaQuery.of(context).size.width * 0.3,
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          Text(
                            'Empty Inbox',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  : Obx(() => ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () =>
                                Get.toNamed(Routes.MESSAGE, arguments: {
                              'userId':
                                  LocalPreferences.getCurrentLoginInfo().id ==
                                          InboxController.chats[index]
                                              .participants!.participant1
                                      ? InboxController.chats[index]
                                          .participants!.participant2
                                      : InboxController.chats[index]
                                          .participants!.participant1
                            }),
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surfaceVariant,
                              backgroundImage: const CachedNetworkImageProvider(
                                  PLACEHOLDER_PHOTO),
                            ),
                            title: FutureBuilder(
                                future: controller.getProfileInfo(
                                    LocalPreferences.getCurrentLoginInfo().id ==
                                            InboxController.chats[index]
                                                .participants!.participant1
                                        ? InboxController.chats[index]
                                            .participants!.participant2
                                        : InboxController.chats[index]
                                            .participants!.participant1),
                                builder: (context, snapshot) {
                                  return Text(
                                    snapshot.data?.data?.first.name ??
                                        'Unknown',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  );
                                }),
                            subtitle: Obx(() => Text(
                                  InboxController
                                          .chats[index].lastMessage?.message ??
                                      '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )),
                            trailing: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Obx(() => Text(
                                    timeago.format(InboxController.chats[index]
                                            .lastMessage!.createdAt!),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant),
                                  )),
                            ),
                          );
                        },
                        itemCount: InboxController.chats.value.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 0.4,
                            indent: 20,
                            endIndent: 20,
                          );
                        },
                      )));
            }));
  }
}
