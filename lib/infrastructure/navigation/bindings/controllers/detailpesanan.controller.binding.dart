import 'package:get/get.dart';

import '../../../../presentation/karyawanpage/detailpesanan/controllers/detailpesanan.controller.dart';

class DetailpesananControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailpesananController>(
      () => DetailpesananController(),
    );
  }
}
