import 'dart:convert';

import 'package:ecom_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/Cart.dart';
import '../models/Product.dart';

class CartController extends GetxController {
  var numOfItems = 1.obs;

  var totalQty = 0.obs;

  var totalAmount = 0.0.obs;

  var cartItems = <CartItemListModel>[].obs;
  var orderIsOk = true.obs;

  void removeItem() {
    if (numOfItems.value > 1) {
      numOfItems.value--;
    }
  }

  void addItem() {
    numOfItems.value++;
  }

  void addItemInCart(Product product) {
    final index = cartItems.indexWhere((element) => element.product == product);

    if (index >= 0) {
      cartItems[index] = CartItemListModel(
          product: product, qty: (numOfItems.value + cartItems[index].qty));
    } else {
      cartItems.add(CartItemListModel(product: product, qty: numOfItems.value));
    }

    //totalQty.value = totalQty.value + numOfItems.value;

    totalAmount.value = totalAmount.value +
        (product.listPrice * numOfItems.value).toPrecision(2);
    numOfItems.value = 1;

    Get.snackbar("Produit Ajouté", "Vous avez ${product.name} au panier",
        snackPosition: SnackPosition.TOP, duration: const Duration(seconds: 3));
  }

  void removeItemFromCart(CartItemListModel currentItem) {
    cartItems.remove(currentItem);
    totalAmount.value = totalAmount.value -
        (currentItem.product.listPrice * currentItem.qty).toPrecision(2);
  }

  void initializeQuantity() {
    numOfItems.value = 1;
  }

  create_order() async {
    var sessionId = "";
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionId = prefs.getString('token')!;
    Map<String, dynamic> dataParams = <String, dynamic>{
      "params": {
        "order_data": [
          for (var element in cartItems)
            {
              "product_id": element.product.id,
              "name": element.product.name,
              "quantity": element.qty,
            }
        ]
      },
    };

    var data = jsonEncode(dataParams);
    print("data  :$data");
    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "X-Openerp-Session-Id": sessionId,
    };

    var uri = Uri.parse("http://192.168.1.4:8069/api/create_ordered");
    var response = await http.post(uri, headers: headers, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print("data jsonResponse :$jsonResponse");
      if (jsonResponse.toString().contains("error")) {
        /* Get.defaultDialog(
            title: "Commande validée",
            middleText: "Vous avez passez votre",
            barrierDismissible: false,
            confirm: noConfirmBtn()); */
        return;
      } else {
        Get.defaultDialog(
            title: "Commande validée",
            middleText: "Votre commande a été envoyé avec succès",
            barrierDismissible: false,
            confirm: confirmBtn());
      }
    }
  }
}

// ignore: non_constant_identifier_names

Widget confirmBtn() {
  return ElevatedButton(
      onPressed: () {
        Get.toNamed(GetRoutes.home);
      },
      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
      child: const Text("OK"));
}

Widget noConfirmBtn() {
  return ElevatedButton(
      onPressed: () {
        Get.back();
      },
      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
      child: const Text("OK"));
}
