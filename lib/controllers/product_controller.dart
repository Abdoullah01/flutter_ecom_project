import 'package:ecom_project/services/product_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/Product.dart';
import '../models/category.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  //var isLoadingRefresh = true.obs;
  var productList = <Product>[].obs;
  var categoryList = <Category>[].obs;

  @override
  void onInit() {
    fetchProducts();
    //refreshData();
    categoryhData();
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

  void categoryhData() async {
    var products = await ProductService.getCategory();
    print(products);
    if (products != null) {
      categoryList.value = products;
    }
  }
}
