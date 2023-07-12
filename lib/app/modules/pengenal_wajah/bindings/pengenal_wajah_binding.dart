import 'package:get/get.dart';

import '../controllers/pengenal_wajah_controller.dart';

class PengenalWajahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengenalWajahController>(
      () => PengenalWajahController(),
    );
  }
}
