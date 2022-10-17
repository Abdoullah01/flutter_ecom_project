import 'package:ecom_project/models/Product.dart';

class CartItemListModel {
  final Product product;
  final int qty;

  CartItemListModel({required this.product, required this.qty});


}

// Demo data for our cart

/* List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItem: 2),
  Cart(product: demoProducts[1], numOfItem: 1),
  Cart(product: demoProducts[3], numOfItem: 1),
]; */
