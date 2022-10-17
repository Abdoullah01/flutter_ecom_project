import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../helper/shared_preference.dart';
import '../models/Product.dart';

class ProductService {
  static var client = http.Client();
  static Future<List<Product>?> getProducts() async {
    var sessionId = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionId = prefs.getString('session_id')!;

    var uri = Uri.parse("http://192.168.1.2:8069/api/get_all_product");
    var response = await client.get(
      uri,
      headers: <String, String>{
        "X-Openerp-Session-Id": sessionId,
      },
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return productFromJson(json);
    }
    return null;
  }

  static Future<String?> getProduct(int productId) async {
    //var sessionId = "";
    var sessionId = SharedPreference().getSessionIdToLogin();
    var uri = Uri.parse("http://192.168.1.2:8069/api/get_product/$productId");
    var response = await client.get(
      uri,
      headers: <String, String>{
        "X-Openerp-Session-Id": sessionId,
      },
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return json;
    }
    return null;
  }
}
