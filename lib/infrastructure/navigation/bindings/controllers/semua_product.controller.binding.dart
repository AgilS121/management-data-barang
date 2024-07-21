import 'package:get/get.dart';

import '../../../../presentation/customerpage/semuaProduct/controllers/semua_product.controller.dart';

class SemuaProductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SemuaProductController>(
      () => SemuaProductController(),
    );
  }
}
