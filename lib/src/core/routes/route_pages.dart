import 'package:get/get_navigation/src/routes/get_route.dart';

import '/src/core/routes/route_name.dart';
import '/src/features/shopping_screen.dart';
import '../../features/product_details_screen.dart';
import '../../features/search_screen.dart';

class RoutePages {
  static List<GetPage<dynamic>>? routes = [
    GetPage(name: RouteNames.home, page: () => const ShoppingScreen()),
    GetPage(
        name: RouteNames.productDetailsScreen,
        page: () => const ProductDetailsScreen()),
    GetPage(name: RouteNames.searchScreen, page: () => SearchScreen()),
    // GetPage(
    //     name: RouteNames.subCategoryScreen,
    //     page: () => const SubCategoryScreen()),
  ];
}
