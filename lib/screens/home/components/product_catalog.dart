import 'package:ecom_project/screens/home/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/coustom_bottom_nav_bar.dart';
import '../../../controllers/product_controller.dart';
import '../../../enums.dart';

class CatalogScreen extends StatelessWidget {
  CatalogScreen({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [builderRender()],
        ),
      ),
      bottomNavigationBar:
          const CustomBottomNavBar(selectedMenu: MenuState.catalog),
    );
  }

  Widget builderRender() {
    return SizedBox(
        height: 250,
        child: GridView.builder(
          itemCount: productController.productList.length,
          shrinkWrap: true,
          primary: true,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.7),
          itemBuilder: (context, index) {
            return ProductWidget(
              product: productController.productList[index],
            );
          },
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Column(
        children: const [
          Text(
            "Catalog",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
