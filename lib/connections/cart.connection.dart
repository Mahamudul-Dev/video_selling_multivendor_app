import 'package:http/http.dart' as http;

import '../app/preferences/local_preferences.dart';
import '../app/utils/constants.dart';

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
      throw e;
    }
  }

  // remove a item from cart
  static Future<http.Response> removeCartItem(String productId) async {
    try {
      final response = await http.delete(Uri.parse('$BASE_URL$CART$productId'),
          headers: {
            'Authorization':
                'Bearer ${LocalPreferences.getCurrentLoginInfo().token}'
          });
      return response;
    } catch (e) {
      throw e;
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
      throw e;
    }
  }
}
