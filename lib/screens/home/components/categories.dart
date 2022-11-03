import 'dart:convert';

import 'package:ecom_project/controllers/product_controller.dart';
import 'package:ecom_project/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  Categories({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    /*  List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/homme.svg", "text": "Homme"},
      {"icon": "assets/icons/femme.svg", "text": "Femme"},
      {"icon": "assets/icons/enfant.svg", "text": "Enfant"},
      {"icon": "assets/icons/sport.svg", "text": "Sport"},
      {"icon": "assets/icons/Discover.svg", "text": "Plus"},
    ]; */

    return Padding(
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
                press: () {
                  print("ok");
                },
              );
            },
          ),
        ));
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

/*  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          productController.categoryList.length,
          (index) => CategoryCard(
            icon: "assets/icons/femme.svg",
            text: productController.categoryList[index].name,
            press: () {
              print("ok");
              print(productController.categoryList.length);
            },
          ),
        ),
      ), */

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
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
              child: SvgPicture.asset(icon!),
            ),
            const SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
