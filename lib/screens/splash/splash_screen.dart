import 'package:ecom_project/screens/splash/components/body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/shared_preference.dart';
import '../../size_config.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
    });
  }

  

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
