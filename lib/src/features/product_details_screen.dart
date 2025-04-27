import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/controller/product_details_controller.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_text_style.dart';
import '../core/widgets/custom_appBar_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductDetailsController controller =
        Get.put(ProductDetailsController());

    return Scaffold(
      appBar: CustomAppbarWidget(
        isSearch: false,
        titleText: controller.product.title.toString(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.whiteColor,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Obx(() => Image.network(
                          controller.selectedImage.value,
                          height: 250.h,
                          width: 300.w,
                          fit: BoxFit.cover,
                        )),
                  ),
                  SizedBox(height: 12.h),
                  controller.product.images!.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                controller.product.images!.map((imageUrl) {
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedImage.value = imageUrl;
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: controller.selectedImage.value ==
                                              imageUrl
                                          ? AppColors.primaryColor
                                          : Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      imageUrl,
                                      height: 80.h,
                                      width: 80.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 280.w,
                        child: Text(
                          controller.product.title.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      Text(controller.product.rating.toString()),
                      SizedBox(width: 2.w),
                      Icon(
                        Icons.star,
                        color: AppColors.primaryColor,
                        size: 20.sp,
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Text(
                        "৳ ${controller.product.price}",
                        style: TextStyle(
                            fontSize: 18.sp, color: AppColors.depBlueColors),
                      ),
                      SizedBox(width: 12.h),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(6.r)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: Text(
                            "Save ${controller.product.discountPercentage}%",
                            style: TextStyle(
                                color: Colors.white, fontSize: 12.sp)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              color: AppColors.whiteColor,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Text(
                controller.product.description.toString(),
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
            SizedBox(height: 8.h),
            // review part
            controller.product.reviews!.isNotEmpty
                ? reviewWidget(controller)
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget reviewWidget(ProductDetailsController controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.product.reviews?.length,
        itemBuilder: (context, index) {
          var review = controller.product.reviews![index];
          return Container(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            color: AppColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.reviewerName.toString(),
                      style: AppTextStyles.titleTextStyle.copyWith(
                          fontSize: 14.sp, color: AppColors.headingTextColor),
                    ),
                    const Spacer(),
                    Text(
                      review.rating.toString(),
                      style: AppTextStyles.titleTextStyle.copyWith(
                          fontSize: 14.sp, color: AppColors.headingTextColor),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.star,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ],
                ),
                Text(
                  review.reviewerEmail.toString(),
                  style: AppTextStyles.subTitleTextStyle.copyWith(
                      fontSize: 10.sp, color: AppColors.secondaryColor),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  review.comment.toString(),
                  style: AppTextStyles.subTitleTextStyle.copyWith(
                      fontSize: 12.sp, color: AppColors.headingTextColor),
                ),
              ],
            ),
          );
        });
  }
}
