import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../app/preferences/local_preferences.dart';
import '../app/data/utils/constants.dart';

class Authentication {
  // call register api
  static Future<http.Response> regsterConnection(
      {required String name,
      required String userName,
      required String email,
      required String password,
      required String accountType}) async {
    try {
      final bodyData = {
        "name": name,
        "userName": userName,
        "email": email,
        "password": password,
        "accountType": accountType
      };
      final response =
          await http.post(Uri.parse(BASE_URL + REGISTER_API), body: bodyData);
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          Logger()
              .e('Request failed with status code ${e.response!.statusCode}');
          Logger().e('Response data: ${e.response!.data}');
        } else {
          Logger().e('Request failed with an error: $e');
        }
      } else {
        Logger().e('An unexpected error occurred: $e');
      }
      throw e;
    }
  }

  // call login api
  static Future<http.Response> loginConnection(
      {required String email, required String password}) async {
    try {
      final bodyData = {"email": email, "password": password};
      final response =
          await http.post(Uri.parse(BASE_URL + LOGIN_API), body: bodyData);
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          Logger()
              .e('Request failed with status code ${e.response!.statusCode}');
          Logger().e('Response data: ${e.response!.data}');
        } else {
          Logger().e('Request failed with an error: $e');
        }
      } else {
        Logger().e('An unexpected error occurred: $e');
      }
      throw e;
    }
  }
}
