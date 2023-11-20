import 'package:http/http.dart' as http;

import '../app/data/models/product_filter.enum.dart';
import '../app/preferences/local_preferences.dart';
import '../app/data/utils/constants.dart';

class ProductsConnection {
  static Future<http.Response> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$PRODUCTS'),
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      return response;
    } catch (e) {
      throw e;
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
          throw e;
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
          throw e;
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
          throw e;
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
          throw e;
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
          throw e;
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
          throw e;
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
          throw e;
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
      throw e;
    }
  }

  static Future<http.Response> getSingleProduct (String productId) async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$PRODUCTS$productId'), headers: {
        'Authorization':
        'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
      });
      return response;
    } catch (e) {
      throw e;
    }
  }
}
