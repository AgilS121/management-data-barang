import 'package:dartz/dartz.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/repositories/ProductRepositories.dart';

class AddProduct {
  final ProductRepository repository;

  AddProduct(this.repository);

  Future<Either<Exception, Product>> call(Product product) {
    return repository.addProduct(product);
  }
}

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<Either<Exception, List<Product>>> call() {
    return repository.getAllProducts();
  }
}

class UpdateProduct {
  final ProductRepository repository;

  UpdateProduct(this.repository);

  Future<Either<Exception, Product>> call(Product product) {
    return repository.updateProduct(product);
  }
}

class DeleteProduct {
  final ProductRepository repository;

  DeleteProduct(this.repository);

  Future<Either<Exception, void>> call(String id) {
    return repository.deleteProduct(id);
  }
}
