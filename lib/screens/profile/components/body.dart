import 'package:ecom_project/constants.dart';
import 'package:flutter/material.dart';

import '../../../helper/shared_preference.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  Body({super.key});
  bool isLoding = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Mon Compte",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          !isLoding
              ? ProfileMenu(
                  text: "Déconnexion",
                  icon: "assets/icons/Log out.svg",
                  press: () async {
                    await SharedPreference().removeSessionIdToLogin();
                    isLoding = true;
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor),
                ),
        ],
      ),
    );
  }
}
