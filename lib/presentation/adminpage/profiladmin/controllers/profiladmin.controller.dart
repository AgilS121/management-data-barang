import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/usecase/Logout.dart';
import 'package:get/get.dart';

class ProfiladminController extends GetxController {
  final Logout logout;
  var user = Rxn<UserEntity>();

  ProfiladminController({
    required this.logout,
  });

  Future<void> signOut() async {
    await logout.call();
    user.value = null;
  }
}
