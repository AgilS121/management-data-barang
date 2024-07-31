import 'package:dekaybaro/domain/core/CartRepository_impl.dart';
import 'package:dekaybaro/domain/repositories/CartRepositories.dart';
import 'package:get/get.dart';
import 'package:dekaybaro/domain/usecase/CartUseCase.dart';
import '../../../../presentation/customerpage/productdetail/controllers/productdetail.controller.dart';

class ProductdetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartRepository>(() => CartRepositoryImpl());
    Get.lazyPut(() => GetCartItemsStream(Get.find<CartRepository>()));
    Get.lazyPut(() => GetCartItemsStreamwhereuser(Get.find<CartRepository>()));
    Get.lazyPut(() => AddToCart(Get.find<CartRepository>()));
    Get.lazyPut<ProductdetailController>(
      () => ProductdetailController(
          addToCartUseCase: Get.find<AddToCart>(),
          getCartItemsUseCase: Get.find<GetCartItemsStream>(),
          getCartItemsStreamwhereuser: Get.find<GetCartItemsStreamwhereuser>()),
    );
  }
}
