import 'dart:convert';
import 'package:ecom_project/routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  Future<void> register() async {
    const String BASE_URL = "http://192.168.1.18:8069/";
    try {
      var headers = {'Content-Type': 'application/json'};
      var url = Uri.parse("${BASE_URL}api/users");
      final Map<String, dynamic> dataParams = <String, dynamic>{
        'login': emailController.text.trim(),
        'name': nameController.text,
        'password': passwordController.text,
       // 'confirm_password': passwordConfirmController.text
      };
      final Map<String, dynamic> data = <String, dynamic>{
        "params": dataParams
      };

      var response =
          await http.post(url, body: jsonEncode(data), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['result']['status'] == 200) {
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          Get.toNamed(GetRoutes.completeProfileScreen);
          //Get.offAllNamed(GetRoutes.signIn);
        } else {
          throw jsonDecode(response.body)['result']['message'] ??
              "Unknown Error Occured";
        }
      } else {
        throw jsonDecode(response.body)['result']['message'] ??
            "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      print(e.toString());
    }
  }
}
