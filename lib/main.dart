import 'package:ecom_project/routes.dart';
import 'package:ecom_project/screens/home/home_screen.dart';
import 'package:ecom_project/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/cart_controller.dart';
import 'controllers/login_controller.dart';
import 'helper/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MyApp());
  _checkSessionId();
}

_checkSessionId() async {
  //var s = SharedPreference().getSessionIdToLogin();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final st = prefs.getString('session_id');
  print("session id ========= $st");
  if (st != null) {
    Get.offAll(() => const HomeScreen());
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CartController cartcontroller = Get.put(CartController());

  LoginController loginController = Get.put(LoginController());

  checkSessionId() async {
    var s = SharedPreference().getSessionIdToLogin();
    if (s != null) {
      Get.offAllNamed(GetRoutes.home);
    }
  }

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
      navigatorKey: Get.key,
    );
  }
}
