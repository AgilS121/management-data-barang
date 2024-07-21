import 'package:get/get.dart';

import '../../../../presentation/customerpage/addalamat/controllers/addalamat.controller.dart';

class AddalamatControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddalamatController>(
      () => AddalamatController(),
    );
  }
}
