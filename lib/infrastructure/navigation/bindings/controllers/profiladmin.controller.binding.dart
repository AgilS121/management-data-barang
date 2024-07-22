import 'package:get/get.dart';

import '../../../../presentation/adminpage/profiladmin/controllers/profiladmin.controller.dart';

class ProfiladminControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfiladminController>(
      () => ProfiladminController(),
    );
  }
}
