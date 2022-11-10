import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constants.dart';

class DialogHelper {
  //show error dialog
  static void showErroDialog(
      {String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline4,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.headline6,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}

var alertStyle = AlertStyle(
  overlayColor: kPrimaryColor,
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  animationDuration: const Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
    side: const BorderSide(
      color: Colors.white,
    ),
  ),
  titleStyle: const TextStyle(
    color: kPrimaryColor,
  ),
);

showCustomDialog(
    BuildContext context, String title, desc, AlertType type, Widget child) {
  Alert(
    context: context,
    style: alertStyle,
    type: type,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
          onPressed: () => Navigator.pop(context),
          color: kPrimaryColor,
          radius: BorderRadius.circular(10.0),
          child: child),
    ],
  ).show();
}
