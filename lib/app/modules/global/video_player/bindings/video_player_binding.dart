import 'package:get/get.dart';

import '../controllers/global_video_player_controller.dart';

class VideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GlobalVideoPlayerController>(
      () => GlobalVideoPlayerController(),
    );
  }
}
