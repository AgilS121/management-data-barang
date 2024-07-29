import 'package:dekaybaro/domain/models/ProductModel.dart';

abstract class CartRepository {
  Future<List<Product>> getCartItems();
  Future<void> addToCart(Product product, int quantity);
  Future<void> removeFromCart(Product product);
  Future<void> updateCartItem(Product product, int quantity);
}
