import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/product_controller.dart';
import '../../../models/Product.dart';
import '../../../routes.dart';
import '../../../size_config.dart';
import 'all_category.dart';
import 'category_product_widget.dart';

class CategoryListScreen extends StatelessWidget {
  CategoryListScreen({super.key});

  final ProductController productController = Get.put(ProductController());

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        "Categories Articles",
        style: TextStyle(color: Colors.black),
      ),
      centerTitle: true,
      elevation: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Padding(
            padding: EdgeInsets.all(getProportionateScreenWidth(20)),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: productController.categoryList.length,
                itemBuilder: (context, index) {
                  return CategoryBox(
                      category: productController.categoryList[index],
                      press: () {});
                },
              ),
            )));
  }
}

class CategoryBox extends StatelessWidget {
  final Category category;
  final GestureTapCallback press;
  const CategoryBox({super.key, required this.category, required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.only(right: 5.0),
        width: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFFFECDF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xFFFFECDF)),
                child: category.image1920 != false
                    ? Image.memory(const Base64Decoder()
                        .convert(category.image1920.split(',').last))
                    : const Icon(Icons.man),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(category.name, textAlign: TextAlign.center)),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.press,
    required this.category,
  }) : super(key: key);

  final Category category;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: const Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: category.image1920 != false
                  ? Image.memory(const Base64Decoder()
                      .convert(category.image1920.split(',').last))
                  : const Icon(Icons.category),
            ),
            const SizedBox(height: 5),
            Text(category.name, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
