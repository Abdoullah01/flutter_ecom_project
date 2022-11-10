import 'dart:convert';

import 'package:ecom_project/controllers/login_controller.dart';
import 'package:ecom_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../controllers/sign_up_controller.dart';
import '../../../helper/keyboard.dart';
import '../../../helper/shared_preference.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
  bool isLoading = false;
  final List<String?> errors = [];
  final LoginController loginController = Get.find();
  final RegisterationController registerationController =
      Get.put(RegisterationController());

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed(GetRoutes.forgotPasswordScreen),
                // Navigator.pushNamed(
                //    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Mot de passe oublié",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          !isLoading
              ? DefaultButton(
                  text: "Continue",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // if all are valid then go to success screen
                      KeyboardUtil.hideKeyboard(context);
                      var res = await loginController.login();
                      if (res.body.contains("error")) {
                        addError(
                            error:
                                "Vérifiez votre mot de passe ou votre email");
                      } else {
                        String rawCookie = res.headers['set-cookie']!;
                        int index = rawCookie.indexOf(';');
                        String refreshToken = (index == -1)
                            ? rawCookie
                            : rawCookie.substring(0, index);
                        int idx = refreshToken.indexOf("=");
                        String sessionId =
                            refreshToken.substring(idx + 1).trim();
                        await SharedPreference().setSessionIdToLogin(sessionId);
                        Get.offAllNamed(GetRoutes.home);
                      }
                      setState(() {
                        isLoading = true;
                      });
                      //registerationController.getSession();
                      //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                    }
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor,),
                ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: loginController.passwordController,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 4) {
          removeError(error: kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Mot de passe",
        hintText: "Entrez votre mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: loginController.emailController,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } /* else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return ""; */
        //}
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Entrez votre email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
