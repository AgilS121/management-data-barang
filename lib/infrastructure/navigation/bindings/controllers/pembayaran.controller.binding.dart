import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:get/get.dart';

import '../../../../presentation/customerpage/pembayaran/controllers/pembayaran.controller.dart';

class PembayaranControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PembayaranController>(
      () => PembayaranController(),
    );
    Get.lazyPut<ProductcardkeranjangcontrollerController>(
      () => ProductcardkeranjangcontrollerController(),
    );
  }
}
