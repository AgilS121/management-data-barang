import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/repositories/AuthRepositories.dart';

class RegisterWithEmail {
  final AuthRepository repository;

  RegisterWithEmail(this.repository);

  Future<UserEntity?> call(String email, String password, String name) async {
    return await repository.registerWithEmail(email, password, name);
  }
}
