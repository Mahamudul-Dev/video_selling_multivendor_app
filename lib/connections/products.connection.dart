
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:video_selling_multivendor_app/app/data/models/product.model.dart';

import '../app/data/utils/enums.dart';
import '../app/data/preferences/local_preferences.dart';
import '../app/data/utils/constants.dart';

class ProductsConnection {
  static final _dio = Dio();
  static Future<http.Response> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$PRODUCTS'),
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> getProductByFilter(Filter filter) async {
    switch (filter) {
      case Filter.SALEH2L:
        try {
          final response = await http.get(
              Uri.parse('${BASE_URL + FILTER_PRODUCT}totalSalesHighToLow'),
              headers: {
                'Authorization':
                    'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
              });
          return response;
        } catch (e) {
          rethrow;
        }

      case Filter.SALEL2H:
        try {
          final response = await http.get(
              Uri.parse('${BASE_URL + FILTER_PRODUCT}totalSalesLowToHigh'),
              headers: {
                'Authorization':
                    'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
              });
          return response;
        } catch (e) {
          rethrow;
        }

      case Filter.RATINGH2L:
        try {
          final response = await http.get(
              Uri.parse('${BASE_URL + FILTER_PRODUCT}ratingHighToLow'),
              headers: {
                'Authorization':
                    'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
              });
          return response;
        } catch (e) {
          rethrow;
        }

      case Filter.RATINGL2H:
        try {
          final response = await http.get(
              Uri.parse('${BASE_URL + FILTER_PRODUCT}ratingLowToHigh'),
              headers: {
                'Authorization':
                    'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
              });
          return response;
        } catch (e) {
          rethrow;
        }

      case Filter.PRICEH2L:
        try {
          final response = await http.get(
              Uri.parse('${BASE_URL + FILTER_PRODUCT}priceHighToLow'),
              headers: {
                'Authorization':
                    'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
              });
          return response;
        } catch (e) {
          rethrow;
        }

      case Filter.PRICEL2H:
        try {
          final response = await http.get(
              Uri.parse('${BASE_URL + FILTER_PRODUCT}priceLowToHigh'),
              headers: {
                'Authorization':
                    'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
              });
          return response;
        } catch (e) {
          rethrow;
        }

      default:
        try {
          final response = await http.get(
              Uri.parse('${BASE_URL + FILTER_PRODUCT}totalSalesHighToLow'),
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

  static Future<http.Response> searchProduct(String query) async {
    try {
      final response = await http
          .get(Uri.parse('$BASE_URL$SEARCH_PRODUCTS$query'), headers: {
        'Authorization':
            'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> getSingleProduct(String productId) async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$PRODUCTS$productId'),
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> uploadVideo(ProductModel product,Function(int) onUploadProgress) async {
    try {

      Logger().i(product.toJson());

      // Create FormData for the video file
      FormData formData = FormData.fromMap({
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "category": product.category,
        "tags": product.tags,
        "duration": product.duration,
        "thumbnail": await MultipartFile.fromFile(
          product.thumbnail!,
        ),
        "downloadUrl": await MultipartFile.fromFile(
          product.downloadUrl!,
        ),
        "previewUrl": await MultipartFile.fromFile(
          product.previewUrl!,
        )
      });

      // Send the video file using Dio with onSendProgress callback
      final res = await _dio.post(
        BASE_URL+PRODUCTS,
        data: formData,
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          }
        ),
        onSendProgress: (int sent, int total) {
          final percentage = (sent / total * 100).toInt();
          Logger().i({'Uploading_Progress: ': percentage});
          onUploadProgress(percentage);
        },
      );


      print("Video uploaded successfully!");
      return res;
    } catch (error) {
      print("Error uploading video: $error");
      rethrow; // Rethrow the error to handle it appropriately in the UI
    }
  
  }

}
