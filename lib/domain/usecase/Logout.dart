import 'package:dekaybaro/domain/repositories/AuthRepositories.dart';

class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  Future<void> call() async {
    await repository.logout();
  }
}
