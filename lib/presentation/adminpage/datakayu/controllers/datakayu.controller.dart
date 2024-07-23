import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:get/get.dart';

class DatakayuController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxMap<int, int> quantities = <int, int>{}.obs;

  final RxBool isFavorite = false.obs;
  final RxList<Product> product = <Product>[].obs;

  void toggleFavorite() {
    isFavorite.toggle();
    // Here you could also implement logic to save the favorite status
  }

  void deleteProduct() {
    // Implement delete logic here
    // print('Deleting product: ${product.value.name}');
    // After deletion, you might want to navigate back
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Product) {
      product.value = Get.arguments;
    }
    // Contoh data
    cartItems.addAll([
      Product(
          id: 1,
          name: 'Kayu Alba',
          price: 900000,
          image: [
            'https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-2048x998-yjzeuy4v.png'
          ],
          stok: 3),
      Product(
          id: 2,
          name: 'Kayu Jati',
          price: 1500000,
          image: [
            'https://static-00.iconduck.com/assets.00/404-page-not-found-illustration-2048x998-yjzeuy4v.png'
          ],
          stok: 0),
    ]);
    for (var item in cartItems) {
      quantities[item.id!] = 1;
    }
  }

  void increaseQuantity(Product product) {
    quantities[product.id!] = (quantities[product.id] ?? 0) + 1;
  }

  void decreaseQuantity(Product product) {
    if ((quantities[product.id] ?? 0) > 0) {
      quantities[product.id!] = quantities[product.id]! - 1;
      if (quantities[product.id] == 0) {
        removeItem(product);
      }
    }
  }

  void removeItem(Product product) {
    cartItems.remove(product);
    quantities.remove(product.id);
  }

  int getQuantity(Product product) {
    return quantities[product.id] ?? 0;
  }
}
