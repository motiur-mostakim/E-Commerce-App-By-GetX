import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyles {
  bool isButtonEnabled = false;

  AppTextStyles._();

  static TextStyle get titleTextStyle => TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w500, color: AppColors.textColor);

  static TextStyle get subTitleTextStyle => TextStyle(
      fontSize: 13.sp, fontWeight: FontWeight.w400, color: AppColors.textColor);
}
