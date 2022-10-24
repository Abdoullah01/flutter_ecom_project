import 'package:ecom_project/services/product_service.dart';
import 'package:get/get.dart';

import '../models/Product.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  //var isLoadingRefresh = true.obs;
  var productList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    //refreshData();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ProductService.getProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }

  void refreshData() async {
    var products = await ProductService.getProducts();
       if (products != null) {
        productList.value = products;
      } 

  }
}
