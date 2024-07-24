import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/repositories/AuthRepositories.dart';

class LoginWithGoogle {
  final AuthRepository repository;

  LoginWithGoogle(this.repository);

  Future<UserEntity?> call() async {
    return await repository.loginWithGoogle();
  }
}
