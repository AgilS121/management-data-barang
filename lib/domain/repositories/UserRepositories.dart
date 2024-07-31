import 'package:dekaybaro/domain/entities/UserEntitites.dart';

abstract class UserRepository {
  Future<UserEntity?> getCurrentUser();
}
