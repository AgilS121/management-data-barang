import 'package:dekaybaro/domain/models/ProductModel.dart';

abstract class CartRepository {
  Stream<List<Product>> getCartItemsStream();
  Future<void> addToCart(Product product, int quantity, String emailpembeli);
  Future<void> removeFromCart(Product product);
  Future<void> updateCartItem(Product product, int quantity);
  Stream<List<Product>> getCartItemsStreamwhereuser(String userEmail);
}
