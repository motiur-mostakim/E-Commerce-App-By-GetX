import 'package:ecommerce_app/src/features/sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '/src/core/utils/app_string.dart';
import '/src/core/widgets/custom_appBar_widget.dart';
import '../core/controller/categories_controller.dart';
import '../core/controller/product_controller.dart';
import '../core/routes/route_name.dart';
import '../core/utils/app_colors.dart';
import '../core/widgets/category_widget.dart';
import '../core/widgets/product_card.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.put(CategoryController());
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppbarWidget(
        isSearch: true,
        titleText: AppString.shoppingText,
      ),
      body: Obx(() {
        final showSeeMoreButton = categoryController.categories.length >
            categoryController.visibleLimit;

        return productController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                controller: productController.scrollController,
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categoryController.visibleCategories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final category =
                            categoryController.visibleCategories[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => SubCategoryScreen(
                                categorySlug: category.slug ?? ''));
                          },
                          child: CategoryWidget(
                            images: "",
                            titleText: category.name ?? '',
                          ),
                        );
                      },
                    ),
                    if (showSeeMoreButton)
                      Center(
                        child: GestureDetector(
                          onTap: categoryController.toggleShowAll,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15.h),
                            height: 35.h,
                            width: 90.w,
                            child: Card(
                              elevation: 6,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 5.w),
                                  Text(
                                    categoryController.showAll.value
                                        ? "See less"
                                        : "See more",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.depBlueColors,
                                    ),
                                  ),
                                  Icon(
                                    categoryController.showAll.value
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    size: 23,
                                    color: AppColors.depBlueColors,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: productController.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.76,
                      ),
                      itemBuilder: (context, index) {
                        final product = productController.products[index];
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
                    ),
                    if (productController.isMoreLoading.value)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 26.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              );
      }),
    );
  }
}
