import 'dart:convert';

import 'package:ecom_project/screens/home/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/coustom_bottom_nav_bar.dart';
import '../../../constants.dart';
import '../../../controllers/product_controller.dart';
import '../../../enums.dart';
import '../../../routes.dart';
import '../../details/details_screen.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Produits",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: productController.productList.length,
          shrinkWrap: true,
          primary: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 5.0),
          itemBuilder: (context, index) {
            if (productController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              );
            } else {
              return ProductWidget(
                  product: productController.productList[index]);
            }
          },
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.catalog),
    );
  }
}
