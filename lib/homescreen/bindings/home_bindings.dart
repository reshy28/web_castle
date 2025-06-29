import 'package:get/get.dart';
import 'package:web_castle/homescreen/controller/homescreen_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomescreenController>(() => HomescreenController());
  }
}
