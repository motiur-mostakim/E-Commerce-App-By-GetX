import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../routes/route_name.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';

class CustomAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? titleText;
  final bool? isBack;
  final bool? isSearch;

  const CustomAppbarWidget({
    super.key,
    this.titleText,
    this.isBack,
    this.isSearch,
  });

  @override
  Size get preferredSize => Size.fromHeight(50.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              strokeAlign: BorderSide.strokeAlignOutside,
              color: AppColors.imageBgColor,
              width: .8,
              style: BorderStyle.solid)),
      elevation: 0,
      leading: isBack == true
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ))
          : null,
      title: Text(titleText!, style: AppTextStyles.titleTextStyle),
      centerTitle: false,
      backgroundColor: Colors.white,
      actions: [
        isSearch == true
            ? IconButton(
                onPressed: () {
                  Get.toNamed(RouteNames.searchScreen);
                },
                icon: const Icon(Icons.search))
            : const SizedBox()
      ],
    );
  }
}
