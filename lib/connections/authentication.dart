import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:video_selling_multivendor_app/app/constants/utils.dart';

class Authentication {
  static final _dio = Dio();

  // call register api
  static Future<Response> regsterConnection(
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
      final response = await _dio.post(BASE_URL + REGISTER_API, data: bodyData);
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
  static Future<Response> loginConnection(
      {required String email, required String password}) async {
    try {
      final bodyData = {"email": email, "password": password};
      final response = await _dio.post(BASE_URL + LOGIN_API, data: bodyData);
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

  static Future<Response> userProfileConnection({required String id}) async {
    try {
      final response =
          await _dio.get(BASE_URL + USER_API, queryParameters: {'id': id});
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
