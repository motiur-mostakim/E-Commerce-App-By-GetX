import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/product_model.dart';
import '../utils/constant.dart';

class ProductSearchController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <Product>[].obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(searchText, (val) {
      searchProducts(val);
    }, time: const Duration(milliseconds: 500));
  }

  void onSearchChanged(String value) {
    searchText.value = value;
  }

  Future<void> searchProducts(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;
    final url = Uri.parse("${AppConstant.productSearchApiUrl}$query");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final productModel = ProductModel.fromJson(json.decode(response.body));
        searchResults.value = productModel.products ?? [];
      } else {
        searchResults.clear();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
