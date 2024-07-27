import 'package:dekaybaro/domain/entities/UserEntitites.dart';

abstract class AuthRepository {
  Future<UserEntity?> loginWithEmail(String email, String password);
  Future<UserEntity?> registerWithEmail(
      String email, String password, String name);
  Future<UserEntity?> loginWithGoogle();
  Future<void> logout();
}
