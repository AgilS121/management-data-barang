import 'package:get/get.dart';

import '../../../../presentation/customerpage/homecustomer/controllers/homecustomer.controller.dart';

class HomecustomerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomecustomerController>(
      () => HomecustomerController(),
    );
  }
}
