import 'package:get/get.dart';

import '../../../../presentation/customerpage/detailproduk/controllers/detailproduk.controller.dart';

class DetailprodukControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailprodukController>(
      () => DetailprodukController(),
    );
  }
}
