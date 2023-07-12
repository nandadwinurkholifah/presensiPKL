import 'package:get/get.dart';

import '../controllers/home_mhs_controller.dart';

class HomeMhsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeMhsController>(
      () => HomeMhsController(),
    );
  }
}
