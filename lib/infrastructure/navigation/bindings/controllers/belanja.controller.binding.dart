import 'package:get/get.dart';

import '../../../../presentation/customerpage/belanja/controllers/belanja.controller.dart';

class BelanjaControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BelanjaController>(
      () => BelanjaController(),
    );
  }
}
