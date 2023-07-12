import 'package:get/get.dart';

import '../controllers/home_pmb_controller.dart';

class HomePmbBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePmbController>(
      () => HomePmbController(),
    );
  }
}
