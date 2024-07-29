import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/repositories/CartRepositories.dart';

class GetCartItems {
  final CartRepository repository;

  GetCartItems(this.repository);

  Future<List<Product>> call() {
    return repository.getCartItems();
  }
}

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call(Product product, int quantity) {
    return repository.addToCart(product, quantity);
  }
}

class RemoveFromCart {
  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call(Product product) {
    return repository.removeFromCart(product);
  }
}

class UpdateCartItem {
  final CartRepository repository;

  UpdateCartItem(this.repository);

  Future<void> call(Product product, int quantity) {
    return repository.updateCartItem(product, quantity);
  }
}
