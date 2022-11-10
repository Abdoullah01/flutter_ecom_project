import 'dart:async';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/Product.dart';
import 'app_exception.dart';

class ProductService {
  //static var client = http.Client();
  static Future<List<Product>?> getProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var userSessionId = "";
    userSessionId = prefs.getString('session_id')!;
    //var uri = Uri.parse("http://192.168.1.4:8069/api/get_all_product");
    var uri = Uri.parse("http://188.166.104.18:9011/api/get_all_product");
    try {
      var response = await http.get(
        uri,
        headers: <String, String>{
          "X-Openerp-Session-Id": userSessionId,
        },
      );
      if (response.statusCode == 200) {
        await prefs.setString("products", response.body);
        return productFromJson(response.body);
      }
      return null;
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  static Future<List<Category>?> getCategory() async {
    var userSessionId = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userSessionId = prefs.getString('session_id')!;
    //var uri = Uri.parse("http://192.168.1.4:8069/api/get_all_category");
    var uri = Uri.parse("http://188.166.104.18:9011/api/get_all_category");
    try {
      var response = await http.get(
        uri,
        headers: <String, String>{
          "X-Openerp-Session-Id": userSessionId,
        },
      );
      if (response.statusCode == 200) {
        await prefs.setString("categories", response.body);
        return categoryFromJson(response.body);
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    return null;
  }

  static Future<List<Product>?> getProductByCategory(int categoryId) async {
    var sessionId = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionId = prefs.getString('session_id')!;
    // var uri = Uri.parse("http://192.168.1.4:8069/api/get_product_category/$categoryId");
    var uri = Uri.parse(
        "http://188.166.104.18:9011/api/get_product_category/$categoryId");
    var headers = <String, String>{
      "X-Openerp-Session-Id": sessionId,
    };
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        await prefs.setString("products_category", response.body);
        return productFromJson(response.body);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}
