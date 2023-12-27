import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../app/preferences/local_preferences.dart';
import '../app/data/utils/constants.dart';

class ProfileConnection {
  static Future<http.Response> userProfileConnection(
      {required String id}) async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$USER_API$id'),
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      Logger().i(response.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> updateUserProfileConnection(
      {required String id, required Map<String, dynamic> bodyData}) async {
    try {
      final response = await http
          .put(Uri.parse('$BASE_URL$UPDATE_PROFILE_API$id'), body: jsonEncode(bodyData), headers: {
        'Authorization':
            'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
      });
      Logger().i(response.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.StreamedResponse> uploadProfileImage(
      String filePath) async {
    final request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            '$BASE_URL$UPDATE_PROFILE_API${LocalPreferences.getCurrentLoginInfo().id}'));
    request.files
        .add(await http.MultipartFile.fromPath('profilePic', filePath));
    request.headers.addAll({
      'Authorization': 'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
    });

    try {
      final response = await request.send();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
