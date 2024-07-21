import 'package:get/get.dart';

import '../../../../presentation/customerpage/productdetail/controllers/productdetail.controller.dart';

class ProductdetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductdetailController>(
      () => ProductdetailController(),
    );
  }
}
