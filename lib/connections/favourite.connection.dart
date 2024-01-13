import 'package:http/http.dart' as http;

import '../app/data/preferences/local_preferences.dart';
import '../app/data/utils/constants.dart';

class FavouriteConnection {
  static Future<http.Response> viewFavouriteItem() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$FAVOURITE_API'),
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> removeFavouriteItem(String productId, String favoriteId) async {
    try {
      final response = await http.delete(Uri.parse('$BASE_URL$FAVOURITE_API$favoriteId'),
          body: {
            'productId': productId
          },
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> addFavouriteItem(String productId) async {
    final bodyData = {"productId": productId};
    try {
      final response = await http.post(Uri.parse('$BASE_URL$ADD_FAVOURITE_API'),
          body: bodyData,
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
