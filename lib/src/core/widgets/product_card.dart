import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String? images;
  final String? productName;
  final String? price;
  final VoidCallback? onTapFunc;

  const ProductCard({
    super.key,
    this.images,
    this.productName,
    this.price,
    this.onTapFunc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunc,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 6),
            height: 230.h,
            width: 156.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(width: 1, color: AppColors.imageBgColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    images!,
                    height: 140.h,
                    width: 140.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.sp, color: AppColors.textColor),
                      ),
                      Text(
                        price!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                          color: AppColors.textColor,
                        ),
                      ),
                      SizedBox(
                        width: 8.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
