import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_test/api/network_service.dart';
import 'package:product_test/api/url_constants.dart';
import 'package:product_test/modules/home/model/product_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _netWorkService = NetworkService();

  var selectedCategories = <String>{}.obs;
  var selectedTags = <String>{}.obs;
  var rangeValues = RangeValues(0, 10000).obs;

  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
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
      log("Erro $e");
    } finally {
      isLoading(false);
    }
  }

  void applyFilters() {
    filteredProducts.value = products.where((product) {
      final matchesCategory = selectedCategories.isEmpty ||
          selectedCategories.contains(product.category);
      final matchesPrice = (product.price ?? 0) >= rangeValues.value.start &&
          (product.price ?? 0) <= rangeValues.value.end;
      final matchesTags = selectedTags.isEmpty ||
          product.tags!.any((tag) => selectedTags.contains(tag));
      return matchesCategory && matchesPrice && matchesTags;
    }).toList();

    log('filtereds length :${filteredProducts.length}');
  }

  searchProducts(String input) {
    if (input.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products
          .where((e) => (e.title ?? '').toLowerCase().contains(input))
          .toList();
    }
  }
}
