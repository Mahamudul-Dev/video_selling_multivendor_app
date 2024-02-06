import 'package:http/http.dart' as http;

import '../app/data/preferences/local_preferences.dart';
import '../app/data/utils/constants.dart';

class PurchaseListConnection {
  static Future<http.Response> getPurchaseList() async {
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
}