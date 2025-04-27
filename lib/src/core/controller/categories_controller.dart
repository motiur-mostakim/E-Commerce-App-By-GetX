import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../model/categories_model.dart';
import '../utils/constant.dart';

class CategoryController extends GetxController {
  var categories = <CategoryModel>[].obs;
  var isLoading = false.obs;
  var showAll = false.obs;
  final int visibleLimit = 8;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(AppConstant.categoriesApiUrl));

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        categories.value =
            data.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch categories");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toggleShowAll() {
    showAll.value = !showAll.value;
  }

  List<CategoryModel> get visibleCategories {
    if (showAll.value) {
      return categories;
    } else {
      return categories.take(visibleLimit).toList();
    }
  }
}
