import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../app/data/utils/constants.dart';
import '../app/data/preferences/local_preferences.dart';

class MessageConnection {
  static final _dio = Dio();
  static Future<Response> getMessages(String participantId) async {
    try {
      final response = await _dio.get('$BASE_URL$MESSAGES_API',
          options: Options(headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          }),
          data: {"receiverId": participantId});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> getInbox() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$INBOX_API'),
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
