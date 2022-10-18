import 'dart:convert';
import 'package:ecom_project/constants.dart';
import 'package:flutter/material.dart';
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

  final String BASE_URL = "http://188.166.104.18:9011/";
  Future<void> login() async {
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
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.toString().contains("error")) {
        Get.defaultDialog(
            title: "Erreur de connexion",
            middleText: "Vérifiez votre login et mot de passe",
            barrierDismissible: false,
            confirm: confirmBtn());
      } else {
        String rawCookie = response.headers['set-cookie']!;
        int index = rawCookie.indexOf(';');
        String refreshToken =
            (index == -1) ? rawCookie : rawCookie.substring(0, index);
        int idx = refreshToken.indexOf("=");
        String sessionId = refreshToken.substring(idx + 1).trim();
        await SharedPreference().setSessionIdToLogin(sessionId);
        Get.toNamed(GetRoutes.loginSuccessScreen);
      }
      //var err = jsonResponse['error'];
      //print("erreur   : $err");

      //return true;
    }
    /* else {
      Get.defaultDialog(
          title: "Erreur de connexion",
          middleText: "Vérifiez votre login et mot de passe"); */
  }

  Widget confirmBtn() {
    return ElevatedButton(
        onPressed: () {
          Get.back();
        },
        style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
        child: const Text("OK"));
  }
}
