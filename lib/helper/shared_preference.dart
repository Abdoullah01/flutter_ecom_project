import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../routes.dart';

class SharedPreference {
  setSessionIdToLogin(sessionId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('session_id', sessionId);
  }

/*     setUserSessionIdToLogin(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  } */

  getSessionIdToLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id');
  }

  removeSessionIdToLogin() async {
    var currentSessionId = "";
    const String BASE_URL = "http://188.166.104.18:9011";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentSessionId = prefs.getString("session_id")!;
    var headers = {
      'Content-Type': 'application/json',
      "X-Openerp-Session-Id": currentSessionId,
    };
    var data = {};
    var url = Uri.parse("$BASE_URL/web/session/destroy");
    var response =
        await http.post(url, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      prefs.remove('session_id');
      Get.toNamed(GetRoutes.signIn);
      print("Logout");
    }
  }
}
