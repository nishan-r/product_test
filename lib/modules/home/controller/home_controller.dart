

import 'dart:developer';

import 'package:product_test/api/network_service.dart';
import 'package:product_test/api/url_constants.dart';
import 'package:product_test/modules/home/model/product_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  
  final _netWorkService = NetworkService();

  var filteredProducts = <Product>[].obs;
  var selectedCategories = <String>{}.obs;
  var selectedTags = <String>{}.obs;
  var maxPrice = 100.0.obs;


  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    isLoading(true);
    try {
      var url = UrlConstants.productUrl;
      final res = await _netWorkService.get(url);
      if (res?.statusCode == 200) {
        final productModel = ProductModel.fromJson(res?.data);
        products.value = productModel.products ?? [];
        applyFilters();
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }


  void applyFilters() {
  filteredProducts.value = products.where((product) {
    final matchesCategory = selectedCategories.isEmpty || selectedCategories.contains(product.category);
    final matchesPrice = (product.price??0) <= maxPrice.value;
    final matchesTags = selectedTags.isEmpty || product.tags!.any((tag) => selectedTags.contains(tag));
    return matchesCategory && matchesPrice && matchesTags;
  }).toList();

  log('filtered length :${filteredProducts.length}');
}
}