import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:get/get.dart';

import '../../../../presentation/customerpage/konfirmasipembayaran/controllers/konfirmasipembayaran.controller.dart';

class KonfirmasipembayaranControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KonfirmasipembayaranController>(
      () => KonfirmasipembayaranController(),
    );
    Get.lazyPut<ProductcardkeranjangcontrollerController>(
      () => ProductcardkeranjangcontrollerController(),
    );
  }
}
