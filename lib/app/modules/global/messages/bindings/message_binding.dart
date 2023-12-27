import 'package:get/get.dart';
import '../../inbox/controllers/inbox_controller.dart';
import '../controllers/message_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageController>(
      () => MessageController(),
    );

    Get.lazyPut<InboxController>(
      () => InboxController(),
    );
  }
}
