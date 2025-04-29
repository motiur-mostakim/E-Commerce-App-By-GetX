import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/controller/sub_category_controller.dart';
import '../core/routes/route_name.dart';
import '../core/utils/app_colors.dart';
import '../core/widgets/custom_appBar_widget.dart';
import '../core/widgets/product_card.dart';

class SubCategoryScreen extends StatelessWidget {
  final String categorySlug;

  const SubCategoryScreen({super.key, required this.categorySlug});

  @override
  Widget build(BuildContext context) {
    final SubCategoryController controller =
        Get.put(SubCategoryController(categorySlug));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppbarWidget(
        titleText: categorySlug.capitalizeFirst ?? '',
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                controller: controller.scrollController,
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.76,
                      ),
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return ProductCard(
                          onTapFunc: () {
                            Get.toNamed(RouteNames.productDetailsScreen,
                                arguments: product);
                          },
                          images: product.thumbnail ?? '',
                          productName: product.title ?? '',
                          price: "\$ ${product.price}",
                        );
                      },
                    ),
                    if (controller.isMoreLoading.value)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 26.0),
                        child: Center(child: CircularProgressIndicator()),
                      )
                  ],
                ),
              );
      }),
    );
  }
}
