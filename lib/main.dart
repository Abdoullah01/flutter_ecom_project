import 'package:ecom_project/routes.dart';
import 'package:ecom_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'controllers/login_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  CartController cartcontroller = Get.put(CartController());
  LoginController loginController = Get.put(LoginController());
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: GetRoutes.splash,
      getPages: GetRoutes.routes,
    );
  }
}
