import 'package:get/get.dart';

import '../../../../presentation/customerpage/akun/controllers/akun.controller.dart';

class AkunControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AkunController>(
      () => AkunController(),
    );
  }
}
