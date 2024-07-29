import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/CartUseCase.dart';
import 'package:get/get.dart';

class ProductdetailController extends GetxController {
  final AddToCart addToCartUseCase;
  final GetCartItems getCartItemsUseCase;
  late var _splitScreenMode = false;

  ProductdetailController({
    required this.addToCartUseCase,
    required this.getCartItemsUseCase,
  });

  final Rx<Product> product = Rx<Product>(Product(
    name: '',
    price: 0,
    image: [],
    adalahKayuGelondongan: false,
    jenisKayu: '',
    kualitas: '',
    deskripsi: '',
  ));
  final selectedImageIndex = 0.obs;
  final isFavorite = false.obs;
  final isAddingToCart = false.obs;
  final cartItemCount = 0.obs;
  final quantity = 1.obs; // Menambahkan properti quantity

  @override
  void onInit() {
    super.onInit();
    _loadProductData();
    updateCartItemCount();
  }

  void _loadProductData() {
    var args = Get.arguments;
    if (args is Product) {
      product.value = args;
    } else {
      print('Error: Expected Product object as argument');
      product.value = Product(
        name: 'Unknown',
        price: 0,
        image: [],
        adalahKayuGelondongan: false,
        jenisKayu: 'Unknown',
        kualitas: 'Unknown',
        deskripsi: 'No description available',
      );
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    // TODO: Implement logic to save favorite status
  }

  Future<void> addToCart() async {
    isAddingToCart.value = true;
    try {
      // Tambahkan produk ke keranjang dengan jumlah yang dipilih
      await addToCartUseCase(product.value, quantity.value);
      await updateCartItemCount();
      Get.snackbar(
        'Sukses',
        'Produk ditambahkan ke keranjang',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menambahkan produk ke keranjang',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isAddingToCart.value = false;
    }
  }

  Future<void> updateCartItemCount() async {
    try {
      final cartItems = await getCartItemsUseCase();
      cartItemCount.value = cartItems.length;
    } catch (e) {
      print('Error updating cart item count: $e');
    }
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }
}
