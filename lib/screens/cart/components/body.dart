import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Obx(
        () => ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              var currentItem = cartController.cartItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CartCard(cartItemListModel: currentItem),
              );
            }),
      ),
    );
  }
}
