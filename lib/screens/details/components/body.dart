import 'package:ecom_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../components/default_button.dart';
import '../../../controllers/cart_controller.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Product product;
  final CartController controller = Get.put(CartController());
  Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: const Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                        child: DefaultButton(
                          text: "Ajouter au panier",
                          press: () {
                            controller.addItemInCart(product);
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Produit Ajouté",
                              desc: "Votre produit a été ajouté au panier.",
                              buttons: [
                                DialogButton(
                                  onPressed: () => Navigator.pop(context),
                                  color: const Color.fromRGBO(0, 179, 134, 1.0),
                                  child: const Text(
                                    "RETOUR",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                DialogButton(
                                  onPressed: () =>
                                      Get.toNamed(GetRoutes.cartScreen),
                                  gradient: const LinearGradient(colors: [
                                    Color.fromRGBO(116, 116, 191, 1.0),
                                    Color.fromRGBO(52, 138, 199, 1.0),
                                  ]),
                                  child: const Text(
                                    "ALLER AU PANIER",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                )
                              ],
                            ).show();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
