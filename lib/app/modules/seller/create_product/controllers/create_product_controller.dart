import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../../../connections/connections.dart';
import '../../../../data/models/product.model.dart';
import '../../../../routes/app_pages.dart';

class CreateProductController extends GetxController {
  TextEditingController videoTitleController = TextEditingController();
  TextEditingController videoDescController = TextEditingController();
  TextEditingController tagEditingFieldController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  ScrollController mediaScrollController = ScrollController();

  RxBool isUploading = false.obs;
  RxInt progress = 0.obs;
  RxString status = ''.obs;

  // late PodPlayerController trailerPlayerController, mainContentController;

  RxString trailerPath = ''.obs;
  Rx<File?> trailerThumbnail = Rx(null);
  RxString mainContentPath = ''.obs;
  Rx<File?> mainContentThumbnail = Rx(null);
  RxString videoThumbnailPath = ''.obs;
  Rx<File?> productThumbnail = Rx(null);


  RxList<String> videoTags = <String>[].obs;
  RxString videoCategory = 'Select Category'.obs;
  RxList<String> allCategories = <String>[
    'Select Category',
    'Web Development',
    'App Development',
    'Pet & Animal',
    'Programming',
    'Consultation'
  ].obs;



  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('app_icon');
  final DarwinInitializationSettings initializationSettingsDarwin =
  const DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false
  );


  void onTagRemove(String tag) {
    videoTags.removeWhere((element) => element == tag);
  }

  void addTag(String tag) {
    tagEditingFieldController.clear();
    videoTags.add(tag);
  }

  void selectCategories(String? category) {
    if (category != null) {
      videoCategory.value = category;
    }
  }


  Future<void> getTrailer() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.video,
  );

  if (result != null && result.files.isNotEmpty) {
    String filePath = result.files.single.path ?? '';
    Logger().i({'Video': filePath});

    // Check file size
    File videoFile = File(filePath);
    int fileSizeInBytes = videoFile.lengthSync();
    int fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024); // Convert to MB

    if (fileSizeInMB > 300) {
      // Show error Snackbar for file size greater than 300 MB
      Get.showSnackbar(const GetSnackBar(message: 'Trailer file must be smaller then 300 MB', backgroundColor: Colors.red, duration: Duration(seconds: 2)));
      return;
    }

    // Check video duration
    final videoInfo = await VideoCompress.getMediaInfo(filePath);
    double videoDurationInSeconds = videoInfo.duration ?? 0.0;
    double videoDurationInMinutes = videoDurationInSeconds / 60000.00;

    Logger().i({
      'Video duration in sec': videoDurationInSeconds,
      'Video duration in min': videoDurationInMinutes
    });

    if (videoDurationInMinutes > 2.00) {
      // Show error Snackbar for video duration longer than 2 minutes
      Get.showSnackbar(const GetSnackBar(message: 'Video duration should be less than 2 minutes', backgroundColor: Colors.red, duration: Duration(seconds: 2),));
      return;
    }

    // Set the trailer path and thumbnail
    trailerPath.value = filePath;
    trailerThumbnail.value = await VideoCompress.getFileThumbnail(trailerPath.value);
    mediaScrollController.animateTo(
              mediaScrollController.position.maxScrollExtent / 2,
              duration: const Duration(seconds: 1), // Adjust the duration as needed
              curve: Curves.easeInOut,
            );
  } else {
    // User canceled file picking
    return Future.value(null);
  }
}

Future<void> getProductThumbnail() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );

  if (result != null && result.files.isNotEmpty) {
    String filePath = result.files.single.path ?? '';
    Logger().i({'Thumbnail path': filePath});

    videoThumbnailPath.value = filePath;

    productThumbnail.value = await VideoCompress.getFileThumbnail(filePath);
  } else {
    // User canceled file picking
    return Future.value(null);
  }
}

  Future<void> getMainContent() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.video,
  );

  if (result != null && result.files.isNotEmpty) {
    String filePath = result.files.single.path ?? '';
    Logger().i({'Video': filePath});

    // Check file size
    File videoFile = File(filePath);
    int fileSizeInBytes = videoFile.lengthSync();
    int fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024); // Convert to MB

    if (fileSizeInMB > 1024) {
      // Show error Snackbar for file size greater than 300 MB
      Get.showSnackbar(const GetSnackBar(title: 'Max file size limit 1 GB', backgroundColor: Colors.red, duration: Duration(seconds: 2)));
      return;
    }

    // Check video duration
    final videoInfo = await VideoCompress.getMediaInfo(filePath);
    double videoDurationInSeconds = videoInfo.duration ?? 0.0;
    double videoDurationInMinutes = videoDurationInSeconds / 60000.00;

    Logger().i({
      'Video duration in sec': videoDurationInSeconds,
      'Video duration in min': videoDurationInMinutes
    });

    if (videoDurationInMinutes > 45.00) {
      // Show error Snackbar for video duration longer than 2 minutes
      Get.showSnackbar(const GetSnackBar(title: 'Video duration must be less then 45 min', backgroundColor: Colors.red, duration: Duration(seconds: 2)));
      return;
    }

    // Set the trailer path and thumbnail
    mainContentPath.value = filePath;
    mainContentThumbnail.value = await VideoCompress.getFileThumbnail(trailerPath.value);
    mediaScrollController.animateTo(
              mediaScrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 1), // Adjust the duration as needed
              curve: Curves.easeInOut,
            );
  } else {
    // User canceled file picking
    return Future.value(null);
  }
  }


  void initializeNotificationChannel () async {

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    Get.toNamed(Routes.PROGRESS);
  }



  Future<void> publishVideo() async {
    late final MediaInfo? compressedTrailer;
    late final MediaInfo? compressedMainVideo;

    
  try{

    isUploading.value = true;

    VideoCompress.compressProgress$.subscribe((event) {
      var e = event.toInt();
      progress.value = e;
      Logger().i({'Progress': event});
      
    });

    status.value = 'Compressing trailer...';

    Logger().i({'Compressing': VideoCompress.isCompressing});

    await VideoCompress.compressVideo(trailerPath.value, quality: VideoQuality.DefaultQuality, deleteOrigin: false, includeAudio: false).then((value) {
      Logger().i({'CompressedTrailer': value});
      compressedTrailer = value;
    });

    status.value = 'Compressing main content...';

    await VideoCompress.compressVideo(mainContentPath.value, quality: VideoQuality.DefaultQuality, deleteOrigin: false, includeAudio: false).then((value) {
      Logger().i({'CompressedMainContent': value});
      compressedMainVideo = value;
    });

    if (VideoCompress.isCompressing) {
      status.value = 'Still compressing...';
    } 

    if (compressedMainVideo != null) {
      

    final product = ProductModel(
      title: videoTitleController.text,
      description: videoDescController.text,
      price: double.tryParse(priceController.text),
      category: videoCategory.value,
      tags: videoTags.value,
      duration: compressedMainVideo!.duration.toString(),
      downloadUrl: compressedMainVideo!.path,
      previewUrl: compressedTrailer!.path,
      thumbnail: videoThumbnailPath.value
    );
    // start uploading

    final response = await ProductsConnection.uploadVideo(product, (percentage) {
      status.value = 'Uploading in progress..';
      progress.value = percentage;
    }
    );

    if(response.statusCode == 200){
      status.value = 'Upload success!';
      Get.snackbar('Congratulations!', 'Video uploaded successfully!.');
      isUploading.value = false;
      Get.back();
    }

    } else {
      Get.snackbar('Opps!', 'Video not found.');
      return;
    }
    
  } catch (e){
    isUploading.value = true;
    VideoCompress.dispose();
    Logger().e(e);
  }
  }


   void closeObservable(){
    videoTitleController.dispose();
    videoDescController.dispose();
    tagEditingFieldController.dispose();
    priceController.dispose();

    isUploading.close();
    progress.close();
    status.close();
    trailerPath.close();
    trailerThumbnail.close();
    mainContentPath.close();
    mainContentThumbnail.close();
    videoThumbnailPath.close();
    videoTags.close();
    videoCategory.close();
    allCategories.close();
  }

  @override
  void onClose() {
    closeObservable();
    super.onClose();
  }
}
