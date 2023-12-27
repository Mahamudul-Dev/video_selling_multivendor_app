import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

import 'package:get/get.dart';
import 'package:video_selling_multivendor_app/app/preferences/local_preferences.dart';

import '../../../../components/loading_animation.dart';
import '../controllers/support_chat_controller.dart';

class SupportChatView extends GetView<SupportChatController> {
  const SupportChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
        body: Tawk(
              directChatLink: 'https://tawk.to/chat/6568d8a2ff45ca7d47855f7c/1hggosfgi',
              visitor: TawkVisitor(
                name: 'Type Your Name',
                email: LocalPreferences.getCurrentLoginInfo().email,
                hash: LocalPreferences.getCurrentLoginInfo().id
              ),
              onLoad: () {
                Get.snackbar('Hey', 'This sassion can be recorded for further improvement.');
              },
              onLinkTap: (String url) {
                print(url);
              },
              placeholder: LoadingAnimation(color: Theme.of(context).colorScheme.primary,)
            )
      );
    
  }
}
