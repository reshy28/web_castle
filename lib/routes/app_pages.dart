import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:web_castle/homescreen/bindings/home_bindings.dart';
import 'package:web_castle/homescreen/view/homescreen_view.dart';
import 'package:web_castle/routes/app_routes.dart';

class AppPages {
  static List<GetPage> appages = <GetPage>[
    GetPage(
      name: AppRoute.homescreen,
      page: () => const HomescreenView(),
      binding: HomeBinding(),
    ),
  ];
}
