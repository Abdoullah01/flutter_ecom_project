import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../controllers/product_controller.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  Body({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (productController.isLoading.value)
          // ignore: curly_braces_in_flow_control_structures
          return const Center(
            child: CircularProgressIndicator(),
          );
        else {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(20)),
                const HomeHeader(),
                SizedBox(height: getProportionateScreenWidth(10)),
                const DiscountBanner(),
                Categories(),
                const SpecialOffers(),
                SizedBox(height: getProportionateScreenWidth(30)),
                PopularProducts(),
                SizedBox(height: getProportionateScreenWidth(30)),
              ],
            ),
          );
        }
      }),
    );
  }
}
