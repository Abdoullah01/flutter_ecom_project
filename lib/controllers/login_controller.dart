import 'dart:convert';
import 'package:ecom_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/shared_preference.dart';
import '../routes.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    super.onInit();
    // checkSessionId();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  /* checkSessionId() async {
    var s = SharedPreference().getSessionIdToLogin();
    if (s != null) {
    Get.offAll(const HomeScreen());
    }
  } */

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  //final String BASE_URL = "http://192.168.1.4:8069/";
  final String BASE_URL = "http://188.166.104.18:9011/";
  Future<void> login() async {
    try {
      var userSessionId = "";
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userSessionId = prefs.getString('session_id')!;
      final Map<String, dynamic> dataJsonrpc = <String, dynamic>{
        "params": {
          "login": emailController.text,
          "password": passwordController.text
        }
      };
      var data = jsonEncode(dataJsonrpc);
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "X-Openerp-Session-Id": userSessionId,
      };
      var url = Uri.parse("${BASE_URL}api/login");
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var sessionId = jsonResponse['result']['session_id'];
        await SharedPreference().setUserSessionIdToLogin(sessionId);

        Get.offAllNamed(GetRoutes.home);
        print("login sessionId $sessionId");
      }
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
  }

/* 
  Widget confirmBtn() {
    return ElevatedButton(
        onPressed: () {
          Get.back();
        },
        style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
        child: const Text("OK"));
  } */
}
      /* if (jsonResponse.toString().contains("error")) {
        Get.defaultDialog(
            title: "Erreur de connexion",
            middleText: "Vérifiez votre login et mot de passe",
            barrierDismissible: false,
            confirm: confirmBtn());
        Get.back();
      } else {
        String rawCookie = response.headers['set-cookie']!;
        int index = rawCookie.indexOf(';');
        String refreshToken =
            (index == -1) ? rawCookie : rawCookie.substring(0, index);
        int idx = refreshToken.indexOf("=");
        String sessionId = refreshToken.substring(idx + 1).trim();
        await SharedPreference().setSessionIdToLogin(sessionId);
        Get.offAllNamed(GetRoutes.home);
      } */