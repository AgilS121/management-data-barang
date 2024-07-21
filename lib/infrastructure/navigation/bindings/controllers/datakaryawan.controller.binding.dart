import 'package:get/get.dart';

import '../../../../presentation/adminpage/datakaryawan/controllers/datakaryawan.controller.dart';

class DatakaryawanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatakaryawanController>(
      () => DatakaryawanController(),
    );
  }
}
