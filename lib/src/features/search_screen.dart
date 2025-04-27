import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/controller/search_controller.dart';
import '../core/routes/route_name.dart';
import '../core/utils/app_colors.dart';
import '../core/widgets/product_card.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final ProductSearchController controller = Get.put(ProductSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: controller.onSearchChanged,
                      decoration: const InputDecoration(
                        hintText: "Search products...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.searchResults.isEmpty) {
                  return const Center(child: Text("No results found."));
                }
                return GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.searchResults.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.76,
                  ),
                  itemBuilder: (context, index) {
                    final product = controller.searchResults[index];
                    return ProductCard(
                      onTapFunc: () {
                        Get.toNamed(RouteNames.productDetailsScreen,
                            arguments: product);
                      },
                      images: product.thumbnail ?? '',
                      productName: product.title ?? '',
                      price: "৳ ${product.price}",
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
