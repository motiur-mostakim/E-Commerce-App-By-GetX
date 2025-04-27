import 'package:get/get.dart';

import '../../model/product_model.dart';

class ProductDetailsController extends GetxController {
  late Product product;
  var selectedImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Product;
    selectedImage.value = product.thumbnail ?? '';
  }
}
