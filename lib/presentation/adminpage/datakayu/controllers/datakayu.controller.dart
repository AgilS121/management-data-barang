import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:get/get.dart';

class DatakayuController extends GetxController {
  final RxList<Product> cartItems = <Product>[].obs;
  final RxMap<int, int> quantities = <int, int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    // Contoh data
    cartItems.addAll([
      Product(id: 1, name: 'Kayu Alba', price: 900000, image: [''], stok: 3),
      Product(id: 2, name: 'Kayu Jati', price: 1500000, image: [''], stok: 0),
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
