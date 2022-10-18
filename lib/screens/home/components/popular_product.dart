import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/product_card.dart';
import '../../../controllers/product_controller.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Produits Populaires", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                productController.productList.length,
                (index) {
                  return ProductCard(
                      product: productController.productList[index]);
// here by default width and height is 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}
