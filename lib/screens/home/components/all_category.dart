import 'package:ecom_project/constants.dart';
import 'package:ecom_project/controllers/product_controller.dart';
import 'package:ecom_project/models/Product.dart';
import 'package:ecom_project/screens/home/components/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/product_service.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final CategoryArguments agrs =
        ModalRoute.of(context)!.settings.arguments as CategoryArguments;
    productController.productByCategoryData(agrs.category.id);
    var categoryName = agrs.category.name;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 2,
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
              return !productController.categoryIsLoading.value
                  ? ProductWidget(
                      product: productController.productByCategoryList[index])
                  : const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
            },
          )))),
    );
  }
}

class CategoryArguments {
  final Category category;
  CategoryArguments({required this.category});
}
