import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:video_selling_multivendor_app/app/data/models/message.model.dart';

import '../app/data/utils/constants.dart';
import '../app/modules/global/inbox/controllers/inbox_controller.dart';
import '../app/preferences/local_preferences.dart';

class SocketService {
  

  static IO.Socket socket = IO.io(
    SOCKET_URL,
    <String, dynamic>{
      'transports': ['websocket'],
      'auth': {'token': LocalPreferences.getCurrentLoginInfo().id}
    },
  );


  static void initializeSocket(){

    socket.onConnect((data) {
      Logger().i('Socket Connection Initialize! $data');

      socket.on('privateMessage', (msg) {

        // InboxController.addChat(MessageModel.fromJson(msg));

        Logger().i({'Message':msg});
      });
    });

    socket.onError((data) {
      Logger().e('Error: $data');
    });

    socket.onConnectError((data) {
      Logger().e('Connectioon Error: $data');
    });
  }

}