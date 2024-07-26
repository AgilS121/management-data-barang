import 'package:dartz/dartz.dart';
import 'package:dekaybaro/domain/repositories/KategoriRepositories.dart';

class AddCategory {
  final ICategoryRepository repository;

  AddCategory(this.repository);

  Future<Either<Exception, void>> call(String category) async {
    try {
      await repository.addCategory(category);
      return Right(null);
    } catch (e) {
      return Left(Exception('Failed to add category'));
    }
  }
}

class GetAllCategories {
  final ICategoryRepository repository;

  GetAllCategories(this.repository);

  Stream<Either<Exception, List<String>>> call() {
    return repository.getAllCategories().map((categories) {
      return Right<Exception, List<String>>(categories);
    }).handleError((error) {
      return Left<Exception, List<String>>(
          Exception('Failed to fetch categories'));
    });
  }
}
