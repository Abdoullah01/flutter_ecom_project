import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/Product.dart';

class ProductService {
  //static var client = http.Client();
  static Future<List<Product>?> getProducts() async {
    var userSessionId = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userSessionId = prefs.getString('token')!;
    //var uri = Uri.parse("http://192.168.1.4:8069/api/get_all_product");
    var uri = Uri.parse("http://188.166.104.18:9011/api/get_all_product");
    var response = await http.get(
      uri,
      headers: <String, String>{
        "X-Openerp-Session-Id": userSessionId,
      },
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return productFromJson(json);
    }
    return null;
  }

  static Future<List<Category>?> getCategory() async {
    var userSessionId = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userSessionId = prefs.getString('token')!;
    print("userSessionId $userSessionId");
    //var uri = Uri.parse("http://192.168.1.4:8069/api/get_all_category");
    var uri = Uri.parse("http://188.166.104.18:9011/api/get_all_category");
    var response = await http.get(
      uri,
      headers: <String, String>{
        "X-Openerp-Session-Id": userSessionId,
      },
    );
    if (response.statusCode == 200) {
      var json = response.body;

      return categoryFromJson(json);
    }
    return null;
  }

  static Future<List<Product>?> getProductByCategory(int categoryId) async {
    var sessionId = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionId = prefs.getString('token')!;
    // var uri = Uri.parse("http://192.168.1.4:8069/api/get_product_category/$categoryId");
    var uri = Uri.parse(
        "http://188.166.104.18:9011/api/get_product_category/$categoryId");
    var headers = <String, String>{
      "X-Openerp-Session-Id": sessionId,
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;
      return productFromJson(json);
    }
    return null;
  }

// ignore: non_constant_identifier_names

}
