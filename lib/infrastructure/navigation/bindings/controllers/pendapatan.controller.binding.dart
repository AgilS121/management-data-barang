import 'package:get/get.dart';

import '../../../../presentation/adminpage/pendapatan/controllers/pendapatan.controller.dart';

class PendapatanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendapatanController>(
      () => PendapatanController(),
    );
  }
}
