import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/usecase/RegisterEmail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
    update();
  }

  final RegisterWithEmail registerWithEmail;
  var user = Rxn<UserEntity>();

  RegisterController({
    required this.registerWithEmail,
  });

  Future<void> register(String email, String password) async {
    user.value = await registerWithEmail.call(email, password);
    print("data user ${user.value} $email $password");
  }
}
