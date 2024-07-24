import 'package:dartz/dartz.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';

abstract class ProductRepository {
  Future<Either<Exception, Product>> addProduct(Product product);
  Future<Either<Exception, List<Product>>> getAllProducts();
  Future<Either<Exception, Product>> updateProduct(Product product);
  Future<Either<Exception, void>> deleteProduct(int id);
}
