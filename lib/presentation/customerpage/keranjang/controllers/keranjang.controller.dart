import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/CartUseCase.dart';
import 'package:get/get.dart';

class KeranjangController extends GetxController {
  final GetCartItems getCartItemsUseCase;
  final AddToCart addToCartUseCase;
  final RemoveFromCart removeFromCartUseCase;
  final UpdateCartItem updateCartItemUseCase;

  final RxList<Product> cartItems = <Product>[].obs;
  final RxMap<String, int> quantities = <String, int>{}.obs;
  final RxBool isLoading = false.obs;

  KeranjangController({
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartItemUseCase,
  });

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    isLoading.value = true;
    try {
      final items = await getCartItemsUseCase();
      cartItems.value = items;
      for (var item in cartItems) {
        quantities[item.id!] = item.stok ?? 1; // Use item quantity if available
      }
    } catch (e) {
      print('Error fetching cart items: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(Product product) async {
    final quantity =
        quantities[product.id!] ?? 1; // Mendapatkan jumlah yang ada
    try {
      await addToCartUseCase(
          product, quantity); // Kirimkan product dan quantity
      await fetchCartItems(); // Refresh cart setelah menambahkan
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> increaseQuantity(Product product) async {
    final currentQty = quantities[product.id!] ?? 0;
    final newQty = currentQty + 1;
    try {
      await updateCartItemUseCase(product, newQty);
      quantities[product.id!] = newQty;
    } catch (e) {
      print('Error increasing quantity: $e');
    }
  }

  Future<void> decreaseQuantity(Product product) async {
    final currentQty = quantities[product.id!] ?? 0;
    if (currentQty > 1) {
      final newQty = currentQty - 1;
      try {
        await updateCartItemUseCase(product, newQty);
        quantities[product.id!] = newQty;
      } catch (e) {
        print('Error decreasing quantity: $e');
      }
    } else {
      await removeItem(product);
    }
  }

  Future<void> removeItem(Product product) async {
    try {
      await removeFromCartUseCase(product);
      cartItems.remove(product);
      quantities.remove(product.id!);
    } catch (e) {
      print('Error removing item: $e');
    }
  }

  int getQuantity(Product product) {
    return quantities[product.id!] ?? 0;
  }
}
