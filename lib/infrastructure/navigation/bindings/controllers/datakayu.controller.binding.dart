import 'package:get/get.dart';

import '../../../../presentation/adminpage/datakayu/controllers/datakayu.controller.dart';

class DatakayuControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatakayuController>(
      () => DatakayuController(),
    );
  }
}
