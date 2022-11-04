import 'package:ecom_project/services/product_service.dart';
import 'package:get/get.dart';
import '../models/Product.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var categoryIsLoading = true.obs;
  var productList = <Product>[].obs;
  var categoryList = <Category>[].obs;
  var productByCategoryList = <Product>[].obs;

  @override
  void onInit() {
    fetchProducts();
    //refreshData();
    //productByCategoryData();
    categoryData();
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

  void categoryData() async {
    var products = await ProductService.getCategory();
    if (products != null) {
      categoryList.value = products;
    }
  }

  void productByCategoryData(int categoryId) async {
    try {
      categoryIsLoading(true);
      var products = await ProductService.getProductByCategory(categoryId);
      if (products != null) {
        productByCategoryList.value = products;
      }
    } finally {
      // TODO
      categoryIsLoading(false);
    }
  }
}
