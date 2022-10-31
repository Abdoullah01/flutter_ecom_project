import 'dart:convert';
import 'package:ecom_project/routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/shared_preference.dart';

class RegisterationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  final String BASE_URL = "http://192.168.1.4:8069/";

  Future<bool> getSession() async {
    try {
      final Map<String, dynamic> dataJsonrpc = <String, dynamic>{
        "jsonrpc": "2.0",
        "params": {"db": "mobile_app", "login": "admin", "password": "admin"}
      };
      var data = jsonEncode(dataJsonrpc);
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse("${BASE_URL}web/session/authenticate");
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("jsonResponse $jsonResponse");
        var sessionId = jsonResponse['result']['session_id'];
        print("sessionId $sessionId");
        await SharedPreference().setSessionIdToLogin(sessionId);
        return true;
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
    return false;
  }

  Future<void> register() async {
    //const String BASE_URL = "http://192.168.1.38:8069";
    var currentSessionId = "";
    var sessionReceved = await getSession();
    print("sessionReceved : $sessionReceved");
    if (sessionReceved == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      currentSessionId = prefs.getString('session_id')!;
      var headers = {
        'Content-Type': 'application/json',
        "X-Openerp-Session-Id": currentSessionId,
      };
      final Map<String, dynamic> dataParams = <String, dynamic>{
        "params": {
          "login": emailController.text.trim(),
          'name': nameController.text,
          "password": passwordController.text
        }
      };
      var data = jsonEncode(dataParams);
      var url = Uri.parse("${BASE_URL}api/create_users");
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("jsonResponse signup: $jsonResponse");
        String sessionId = jsonResponse['result']['session_id'];
        await SharedPreference().setUserSessionIdToLogin(sessionId);
        Get.offAllNamed(GetRoutes.home);
      }
    }
  }
}
