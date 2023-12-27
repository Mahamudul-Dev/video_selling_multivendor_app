import 'package:get/get.dart';

class ProgressModel {
  String videoTitle;
  String? thumbnailPath;
  RxDouble currentProgress;
  RxString progressName;

  ProgressModel({required this.videoTitle, this.thumbnailPath, required this.currentProgress, required this.progressName});
}