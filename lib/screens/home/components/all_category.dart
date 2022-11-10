import 'package:ecom_project/constants.dart';
import 'package:ecom_project/controllers/product_controller.dart';
import 'package:ecom_project/screens/home/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    productController.productByCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments["name"],
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 1,
        centerTitle: true,
      ),
      body: Obx((() => Container(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            itemCount: productController.productByCategoryList.length,
            shrinkWrap: true,
            primary: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 5.0),
            itemBuilder: (context, index) {
              print(productController.productByCategoryList.length);
              if (productController.categoryIsLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );
              } else {
                return productController.productByCategoryList.isEmpty
                    ? const Center(
                        child: Text("Pas de produit"),
                      )
                    : ProductWidget(
                        product:
                            productController.productByCategoryList[index]);
              }
            },
          )))),
    );
  }
}
