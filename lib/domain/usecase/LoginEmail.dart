import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/repositories/AuthRepositories.dart';

class LoginWithEmail {
  final AuthRepository repository;

  LoginWithEmail(this.repository);

  Future<UserEntity?> call(String email, String password) async {
    return await repository.loginWithEmail(email, password);
  }
}
