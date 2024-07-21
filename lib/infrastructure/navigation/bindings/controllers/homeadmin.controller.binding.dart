import 'package:get/get.dart';

import '../../../../presentation/adminpage/homeadmin/controllers/homeadmin.controller.dart';

class HomeadminControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeadminController>(
      () => HomeadminController(),
    );
  }
}
