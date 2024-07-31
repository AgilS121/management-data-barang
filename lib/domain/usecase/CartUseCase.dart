import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/repositories/CartRepositories.dart';

class GetCartItemsStream {
  final CartRepository repository;

  GetCartItemsStream(this.repository);

  Stream<List<Product>> call() {
    return repository.getCartItemsStream();
  }
}

class GetCartItemsStreamwhereuser {
  final CartRepository repository;

  GetCartItemsStreamwhereuser(this.repository);

  Stream<List<Product>> call(String userEmail) {
    return repository.getCartItemsStreamwhereuser(userEmail);
  }
}

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call(Product product, int quantity, String emailpembeli) {
    return repository.addToCart(product, quantity, emailpembeli);
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
