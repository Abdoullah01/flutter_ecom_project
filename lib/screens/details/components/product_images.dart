import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  // ignore: library_private_types_in_public_api
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages>
    with SingleTickerProviderStateMixin {
  int selectedImage = 0;
  String? visualProduct;
  List<String> variantProduct = [];
  late TransformationController controller;
  TapDownDetails? tapDownDetails;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();
    variantProduct.insert(0, widget.product.image1920);
    variantProduct = widget.product.productVariantIds.imageVariant1920;
    controller = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        controller.value = animation!.value;
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(250),
          child: GestureDetector(
            onDoubleTapDown: (details) => tapDownDetails = details,
            onDoubleTap: () {
              final position = tapDownDetails!.localPosition;

              final double scale = 3;
              final x = -position.dx * (scale - 1);
              final y = -position.dy * (scale - 1);
              final zoomed = Matrix4.identity()
                ..translate(x, y)
                ..scale(scale);

              final end =
                  controller.value.isIdentity() ? zoomed : Matrix4.identity();
              animation = Matrix4Tween(begin: controller.value, end: end)
                  .animate(CurveTween(curve: Curves.easeOut)
                      .animate(animationController));

              animationController.forward(from: 0);
            },
            child: InteractiveViewer(
              //clipBehavior: Clip.none,
              transformationController: controller,
              //panEnabled: false,
              //scaleEnabled: false,
              maxScale: 3,
              child: AspectRatio(
                aspectRatio: 1,
                child: Hero(
                  tag: widget.product.id.toString(),
                  child: Image.memory(
                    const Base64Decoder().convert(visualProduct ??
                        widget.product.image1920.split(',').last),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
                widget.product.productVariantIds.imageVariant1920.length,
                (index) => buildSmallProductPreview(index)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          visualProduct = widget
              .product.productVariantIds.imageVariant1920[index]
              .split(',')
              .last;
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.memory(const Base64Decoder()
            .convert(variantProduct[index].split(',').last)),
      ),
    );
  }
}
