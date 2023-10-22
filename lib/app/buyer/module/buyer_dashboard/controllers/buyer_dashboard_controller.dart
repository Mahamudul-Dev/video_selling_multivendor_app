import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../../data/videos.dart';
import '../../../../models/video_item.model.dart';

class BuyerDashboardController extends GetxController {
  RxList<VideoItemModel> trendingVideos = <VideoItemModel>[].obs;
  Future<void> refrashPage() async {
    return await Future.delayed(const Duration(seconds: 1));
  }

  Future<RxList<VideoItemModel>> initializeTrendingVideos() async {
    trendingVideos.clear();
    for (var i = 0; i < demoVideos.length; i++) {
      try {
        Logger().i(demoVideos[i]);
        trendingVideos.add(VideoItemModel.fromJson(demoVideos[i]));
      } catch (e) {
        Logger().e(e);
      }
    }

    Logger().i(trendingVideos.length);

    return trendingVideos;
  }

  @override
  void onClose() {
    trendingVideos.close();
    super.onClose();
  }
}
