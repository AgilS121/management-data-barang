import 'package:dekaybaro/domain/core/CartRepository_impl.dart';
import 'package:dekaybaro/domain/repositories/CartRepositories.dart';
import 'package:dekaybaro/domain/usecase/CartUseCase.dart';
import 'package:get/get.dart';

import '../../../../presentation/customerpage/keranjang/controllers/keranjang.controller.dart';

class KeranjangControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartRepository>(() => CartRepositoryImpl());
    Get.lazyPut(() => GetCartItems(Get.find<CartRepository>()));
    Get.lazyPut(() => AddToCart(Get.find<CartRepository>()));
    Get.lazyPut(() => RemoveFromCart(Get.find<CartRepository>()));
    Get.lazyPut(() => UpdateCartItem(Get.find<CartRepository>()));
    Get.lazyPut(() => KeranjangController(
          getCartItemsUseCase: Get.find<GetCartItems>(),
          addToCartUseCase: Get.find<AddToCart>(),
          removeFromCartUseCase: Get.find<RemoveFromCart>(),
          updateCartItemUseCase: Get.find<UpdateCartItem>(),
        ));
  }
}
