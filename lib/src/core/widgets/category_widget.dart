import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CategoryWidget extends StatelessWidget {
  final String? images;
  final String? titleText;

  const CategoryWidget({
    super.key,
    this.images,
    this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 65.h,
          width: 65.h,
          decoration: BoxDecoration(
            color: AppColors.imageBgColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.image,
                size: 25,
              )
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          textAlign: TextAlign.center,
          titleText!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12.sp, color: AppColors.textColor),
          maxLines: 2,
        )
      ],
    );
  }
}
