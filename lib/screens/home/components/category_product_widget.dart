import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../models/Product.dart';

class CategoryProductWidget extends StatelessWidget {
  const CategoryProductWidget(
      {super.key, required this.category, required this.onPressed});
  final Category category;
  final GestureTapCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.only(top: 10, right: 20, bottom: 20),
          height: 80,
          child: Row(
            children: [
              /* Expanded(
                child: Container(
                    decoration: BoxDecoration(
                  image: DecorationImage(
                      image: MemoryImage(const Base64Decoder()
                          .convert(category.image1920.split(',').last))),
                )),
              ), */
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.childId.isNotEmpty ? category.childId.first : "",
                      style: const TextStyle(
                        color: Color(0xff1b1b1d),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ), /* 
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    productModel,
                    style: CategoryScreenStylies.categoryProductModelStyle,
                  ), */
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff1b1b1d),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
