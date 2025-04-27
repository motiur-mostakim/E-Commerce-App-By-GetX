import 'package:ecommerce_app/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'src/core/routes/route_name.dart';
import 'src/core/routes/route_pages.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(390, 844),
      minTextAdapt: true,
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: RoutePages.routes,
      initialRoute: RouteNames.home,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.imageBgColor,
      ),
    );
  }
}
