import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/data/utils/constants.dart';
import '../../../../components/loading_animation.dart';
import '../../../../data/utils/asset_maneger.dart';
import '../../../../preferences/local_preferences.dart';
import '../../inbox/controllers/inbox_controller.dart';
import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  MessageView({Key? key}) : super(key: key);
  final userId = Get.arguments['userId'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: controller.getConversations(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Stack(
                          fit: StackFit.loose,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                color: Colors.green,
                                height: 30,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: Center(
                                    child: Text('Waiting for connection...',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(color: Colors.white))),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: LoadingAnimation(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            )
                          ],
                        );
                      }

                      return Obx(() => ListView.builder(
                            reverse: true,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                  future: Get.find<InboxController>()
                                      .getProfileInfo(controller
                                          .messages.value[index].senderId),
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      tileColor:
                                          controller.messages[index].senderId ==
                                                  LocalPreferences
                                                          .getCurrentLoginInfo()
                                                      .id
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .surfaceVariant,
                                      leading: CircleAvatar(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        backgroundImage:
                                            CachedNetworkImageProvider(snapshot
                                                            .data
                                                            ?.data
                                                            ?.first
                                                            .profilePic !=
                                                        null &&
                                                    snapshot.data?.data?.first
                                                            .profilePic !=
                                                        'N/A'
                                                ? '$BASE_URL${snapshot.data!.data!.first.profilePic}'
                                                : PLACEHOLDER_PHOTO),
                                      ),
                                      title: Row(
                                        children: [
                                          Expanded(
                                              child: Text(
                                            snapshot.data?.data?.first.name ??
                                                'Unknown',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          )),
                                          Text(
                                            timeago.format(controller
                                                .messages[index].createdAt!),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                          )
                                        ],
                                      ),
                                      subtitle: Text(
                                          controller.messages[index].message ??
                                              '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    );
                                  });
                            },
                            itemCount: controller.messages.length,
                          ));
                    })),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      type: MaterialType.canvas,
                      color: Theme.of(context).colorScheme.surfaceVariant,
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
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  IconButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.surface),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.all(10))),
                      onPressed: () => controller.sendMessage(userId),
                      icon: Icon(
                        Icons.send_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                      ))
                ],
              ),
            )
          ],
        ));
  }
}
