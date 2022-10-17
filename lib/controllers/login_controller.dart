import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../helper/shared_preference.dart';
import '../routes.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    super.onInit();
    //checkSessionId();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  checkSessionId() async {
    var s = SharedPreference().getSessionIdToLogin();
    if (s != null) {
      Get.offAllNamed(GetRoutes.home);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  final String BASE_URL = "http://192.168.1.2:8069/";
  Future login() async {
    try {
      final Map<String, dynamic> dataParams = <String, dynamic>{
        "db": "mobile_app",
        "login": emailController.text,
        "password": passwordController.text
      };
      final Map<String, dynamic> dataJsonrpc = <String, dynamic>{
        "jsonrpc": "2.0",
        "params": dataParams
      };
      var data = jsonEncode(dataJsonrpc);
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      var url = Uri.parse("${BASE_URL}web/session/authenticate");
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 200) {
        String rawCookie = response.headers['set-cookie']!;
        int index = rawCookie.indexOf(';');
        print("index $index");
        String refreshToken =
            (index == -1) ? rawCookie : rawCookie.substring(0, index);
        int idx = refreshToken.indexOf("=");
        String sessionId = refreshToken.substring(idx + 1).trim();
        await SharedPreference().setSessionIdToLogin(sessionId);
        Get.toNamed(GetRoutes.loginSuccessScreen);
        //return true;
      } else {
        Get.defaultDialog(
            title: "Erreur de connexion",
            middleText: "Vérifiez votre login et mot de passe");
      }
    } on Exception catch (e) {
      // TODO

    }
  }
}
