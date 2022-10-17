import 'package:ecom_project/screens/cart/cart_screen.dart';
import 'package:ecom_project/screens/complete_profile/complete_profile_screen.dart';
import 'package:ecom_project/screens/details/details_screen.dart';
import 'package:ecom_project/screens/forgot_password/forgot_password_screen.dart';
import 'package:ecom_project/screens/home/home_screen.dart';
import 'package:ecom_project/screens/login_success/login_success_screen.dart';
import 'package:ecom_project/screens/otp/otp_screen.dart';
import 'package:ecom_project/screens/profile/profile_screen.dart';
import 'package:ecom_project/screens/sign_in/sign_in_screen.dart';
import 'package:ecom_project/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  //HomeScreen.routeName: (context) => const HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
};

class GetRoutes {
  static const String home = "/home";
  static const String splash = "/splash";
  static const String signIn = "/signIn";
  static const String forgotPasswordScreen = "/forgotPasswordScreen";
  static const String loginSuccessScreen = "/loginSuccessScreen";
  static const String signUpScreen = "/signUpScreen";
  static const String completeProfileScreen = "/completeProfileScreen";
  static const String otpScreen = "/otpScreen";
  static const String detailsScreen = "/detailsScreen";
  static const String cartScreen = "/cartScreen";
  static const String profileScreen = "/profileScreen";

  static List<GetPage> routes = [
    GetPage(name: GetRoutes.home, page: () => const HomeScreen()),
    GetPage(name: GetRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: GetRoutes.signIn, page: () => const SignInScreen()),
    GetPage(
        name: GetRoutes.forgotPasswordScreen,
        page: () => ForgotPasswordScreen()),
    GetPage(
        name: GetRoutes.loginSuccessScreen,
        page: () => const LoginSuccessScreen()),
    GetPage(name: GetRoutes.signUpScreen, page: () => SignUpScreen()),
    GetPage(
        name: GetRoutes.completeProfileScreen,
        page: () => CompleteProfileScreen()),
    GetPage(name: GetRoutes.otpScreen, page: () => const OtpScreen()),
    GetPage(name: GetRoutes.detailsScreen, page: () => DetailsScreen()),
    GetPage(name: GetRoutes.cartScreen, page: () => CartScreen()),
    GetPage(name: GetRoutes.profileScreen, page: () => const ProfileScreen()),
  ];
}
