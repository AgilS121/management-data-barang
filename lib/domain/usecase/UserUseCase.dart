import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/repositories/UserRepositories.dart';

class GetCurrentUserUseCase {
  final UserRepository _userRepository;

  GetCurrentUserUseCase(this._userRepository);

  Future<UserEntity?> execute() async {
    return await _userRepository.getCurrentUser();
  }
}
