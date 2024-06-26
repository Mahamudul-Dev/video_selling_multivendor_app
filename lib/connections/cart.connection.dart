import 'package:http/http.dart' as http;

import '../app/data/preferences/local_preferences.dart';
import '../app/data/utils/constants.dart';

class CartConnection {
  // view cart items
  static Future<http.Response> viewCartItem() async {
    try {
      final response = await http.get(Uri.parse('$BASE_URL$CART'), headers: {
        'Authorization':
            'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // remove a item from cart
  static Future<http.Response> removeCartItem(String productId, String cartId) async {
    try {
      final response = await http.delete(Uri.parse('$BASE_URL$CART$cartId'), body: {
        'productId': productId
      }, headers: {
        'Authorization':
            'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // add a item in cart
  static Future<http.Response> addCartItem(String productId) async {
    final bodyData = {"productId": productId};
    try {
      final response = await http.post(Uri.parse('$BASE_URL$ADD_CART'),
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
