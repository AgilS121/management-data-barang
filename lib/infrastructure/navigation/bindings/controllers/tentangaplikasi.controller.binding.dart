import 'package:get/get.dart';

import '../../../../presentation/tentangaplikasi/controllers/tentangaplikasi.controller.dart';

class TentangaplikasiControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TentangaplikasiController>(
      () => TentangaplikasiController(),
    );
  }
}
