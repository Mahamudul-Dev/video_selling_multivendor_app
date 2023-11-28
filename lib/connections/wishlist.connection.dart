import 'package:http/http.dart' as http;

import '../app/preferences/local_preferences.dart';
import '../app/data/utils/constants.dart';

class WishlistConnection {
   static Future<http.Response> viewWishlistItem() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$WISHLIST_API'), headers: {
        'Authorization':
            'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
      });
      return response;
    } catch (e) {
      throw e;
    }
  }

  static Future<http.Response> removeWishlistItem(String productId) async {
    try {
      final response = await http.delete(Uri.parse('$BASE_URL$WISHLIST_API'),
          body: {
            'productId':productId
          },
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      return response;
    } catch (e) {
      throw e;
    }
  }

  static Future<http.Response> addWishlistItem(String productId) async {
    final bodyData = {"productId": productId};
    try {
      final response = await http.post(Uri.parse('$BASE_URL$ADD_WISHLIST_API'),
          body: bodyData,
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