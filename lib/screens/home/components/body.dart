import 'package:ecom_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        return !productController.isLoading.value
            ? RefreshIndicator(
                onRefresh: () {
                  productController.refreshData();
                  return Future<void>.delayed(const Duration(seconds: 3));
                },
                child: SingleChildScrollView(
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
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
      }),
    );
  }
}
