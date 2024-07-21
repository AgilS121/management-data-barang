import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:get/get.dart';

class ProductdetailController extends GetxController {
  late Product product;
  var selectedImageIndex = 0.obs;
  final isFavorite = false.obs;
  final isAddingToCart = false.obs;
  final cartItemCount = 0.obs;

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    // TODO: Implement logic to save favorite status
  }

  Future<void> addToCart() async {
    isAddingToCart.value = true;
    await Future.delayed(
        Duration(milliseconds: 500)); // Simulate network request
    isAddingToCart.value = false;
    cartItemCount.value++;
    Get.snackbar(
      'Sukses',
      'Produk ditambahkan ke keranjang',
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );
    // TODO: Implement actual add to cart logic
  }

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as Product;
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }
}
