import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controllers/cart_controller.dart';
import '../../../models/Cart.dart';
import '../../../size_config.dart';

class CartCard extends StatelessWidget {
  CartCard({Key? key, required this.cartItemListModel}) : super(key: key);

  final CartItemListModel cartItemListModel;
  final CartController cartcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.memory(const Base64Decoder().convert(
                  cartItemListModel.product.image1920.split(',').last)),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItemListModel.product.name,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: "${cartItemListModel.product.listPrice} FCFA",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                  children: [
                    TextSpan(
                        text: "  x${cartItemListModel.qty.toString()}",
                        style: Theme.of(context).textTheme.bodyText1),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        IconButton(
            onPressed: () {
              cartcontroller.removeItemFromCart(cartItemListModel);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ],
    );
  }
}
