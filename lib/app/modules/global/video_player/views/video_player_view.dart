import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pod_player/pod_player.dart';
import '../../../../components/loading_animation.dart';
import '../controllers/global_video_player_controller.dart';

class VideoPlayerView extends GetView<GlobalVideoPlayerController> {
  VideoPlayerView({Key? key}) : super(key: key);
  final id = Get.arguments['id'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: FutureBuilder<PodPlayerController?>(
        future: controller.getPlayerController(id),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () => PodVideoPlayer(
                      controller: snapshot.data!,
                      matchFrameAspectRatioToVideo: true,
                      videoAspectRatio: controller.videoRatio.value == 'P'
                          ? 9.0 / 16.0
                          : controller.videoRatio.value == 'L'
                              ? 16.0 / 9.0
                              : 1.1 / 1.1,
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      children: [
                        Flexible(
                            child: Obx(
                          () => Text(
                            controller.productTitle.value,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )),
                      ],
                    ),
                  ),

                  // product description
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Description',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Flexible(
                            child: Obx(
                          () => Text(
                            controller.productDescription.value,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: LoadingAnimation(),
            );
          }
        },
      ),
    );
  }
}
