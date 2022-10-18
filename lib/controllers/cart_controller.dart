import 'package:get/get.dart';

import '../models/Cart.dart';
import '../models/Product.dart';

class CartController extends GetxController {
  var numOfItems = 1.obs;

  var totalQty = 0.obs;

  var totalAmount = 0.0.obs;

  var cartItems = <CartItemListModel>[].obs;

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
}




  /* var _products = {}.obs;

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }

    Get.snackbar("Product Added", "You added the ${product.name} to the cart",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1));
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere((key, value) => key == product);
    } else {
      _products[product] -= 1;
    }
  }

  get productSubtotal => _products.entries
      .map((product) => product.key.listPrice * product.value)
      .toList();

  get total => _products.entries.isEmpty
      ? 0
      : _products.entries
          .map((product) => product.key.listPrice * product.value)
          .toList()
          .reduce((value, element) => value + element)
          .toStringAsFixed(2);
  get products => _products;
} */
