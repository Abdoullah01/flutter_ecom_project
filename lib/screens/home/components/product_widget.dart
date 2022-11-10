import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../routes.dart';
import '../../../size_config.dart';
import '../../details/details_screen.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(GetRoutes.detailsScreen,
          arguments: ProductDetailsArguments(product: product)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.0),
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: MemoryImage(const Base64Decoder()
                        .convert(product.image1920.split(',').last))),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "${product.listPrice} FCFA",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
