import 'package:get/get.dart';

import '../controllers/add_pembimbing_controller.dart';

class AddPembimbingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPembimbingController>(
      () => AddPembimbingController(),
    );
  }
}
