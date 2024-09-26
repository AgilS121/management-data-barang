import 'package:dekaybaro/domain/core/CartRepository_impl.dart';
import 'package:dekaybaro/domain/repositories/CartRepositories.dart';
import 'package:dekaybaro/domain/usecase/CartUseCase.dart';
import 'package:get/get.dart';

import '../../../../presentation/karyawanpage/productdetailkaryawan/controllers/productdetailkaryawan.controller.dart';

class ProductdetailkaryawanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartRepository>(() => CartRepositoryImpl());
    Get.lazyPut(() => GetCartItemsStream(Get.find<CartRepository>()));
    Get.lazyPut(() => GetCartItemsStreamwhereuser(Get.find<CartRepository>()));
    Get.lazyPut(() => AddToCart(Get.find<CartRepository>()));
    Get.lazyPut<ProductdetailkaryawanController>(
      () => ProductdetailkaryawanController(
          getCartItemsUseCase: Get.find<GetCartItemsStream>(),
          getCartItemsStreamwhereuser: Get.find<GetCartItemsStreamwhereuser>()),
    );
  }
}
