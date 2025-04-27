import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/product_model.dart';
import '../utils/constant.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  int limit = 10;
  int skip = 0;
  int total = 0;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts(isInitialLoad: true);
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchProducts();
    }
  }

  Future<void> fetchProducts({bool isInitialLoad = false}) async {
    try {
      if (isInitialLoad) {
        isLoading.value = true;
        skip = 0;
        products.clear();
      } else {
        isMoreLoading.value = true;
      }
      var url =
          Uri.parse("${AppConstant.productApiUrl}?limit=$limit&skip=$skip");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final productModel = ProductModel.fromJson(data);

        total = productModel.total ?? 0;
        skip += limit;

        products.addAll(productModel.products ?? []);
      } else {
        Get.snackbar("Error", "Failed to fetch products");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }
}
