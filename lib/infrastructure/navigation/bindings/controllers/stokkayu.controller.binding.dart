import 'package:get/get.dart';

import '../../../../presentation/karyawanpage/stokkayu/controllers/stokkayu.controller.dart';

class StokkayuControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StokkayuController>(
      () => StokkayuController(),
    );
  }
}
