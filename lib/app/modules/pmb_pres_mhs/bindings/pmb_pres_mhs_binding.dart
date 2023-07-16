import 'package:get/get.dart';

import '../controllers/pmb_pres_mhs_controller.dart';

class PmbPresMhsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PmbPresMhsController>(
      () => PmbPresMhsController(),
    );
  }
}
