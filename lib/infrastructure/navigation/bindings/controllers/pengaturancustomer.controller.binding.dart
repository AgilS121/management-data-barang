import 'package:get/get.dart';

import '../../../../presentation/customerpage/pengaturancustomer/controllers/pengaturancustomer.controller.dart';

class PengaturancustomerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturancustomerController>(
      () => PengaturancustomerController(),
    );
  }
}
