import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:get/get.dart';

import '../../../../presentation/customerpage/keranjang/controllers/keranjang.controller.dart';

class KeranjangControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeranjangController>(
      () => KeranjangController(),
    );
    Get.lazyPut<ProductcardkeranjangcontrollerController>(
      () => ProductcardkeranjangcontrollerController(),
    );
  }
}
