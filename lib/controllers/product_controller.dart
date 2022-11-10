import 'package:ecom_project/services/product_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/Product.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var categoryIsLoading = false.obs;
  var productList = <Product>[].obs;
  var categoryList = <Category>[].obs;
  var productByCategoryList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    refreshData();
    //productByCategoryData();
    categoryData();
    super.onInit();
  }

  void fetchProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? productsCache = prefs.getString("products");
    try {
      isLoading(true);
      if (productsCache != null) {
        productList.value = productFromJson(productsCache);
        print("Product Cache");
      }
      var products = await ProductService.getProducts();
      if (products != null) {
        productList.value = products;
        print("Product API");
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

  void categoryData() async {
    isLoading(true);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? categories = prefs.getString("categories");
    if (categories != null) {
      categoryList.value = categoryFromJson(categories);
      print(" category 1 :${categoryList.length}");
    }
    var products = await ProductService.getCategory();
    if (products != null) {
      categoryList.value = products;
      print(" category 2 :${categoryList.length}");
      isLoading(false);
      print("ok API ");
    }
  }

  void productByCategoryData() async {
    try {
      categoryIsLoading(true);
      var products =
          await ProductService.getProductByCategory(Get.arguments["id"]);
      if (products != null) {
        productByCategoryList.value = products;
      }
    } finally {
      // TODO
      categoryIsLoading(false);
    }
  }
}
