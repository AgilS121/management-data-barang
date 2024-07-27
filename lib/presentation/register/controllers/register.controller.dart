import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/usecase/RegisterEmail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RegisterWithEmail registerWithEmail;
  var user = Rxn<UserEntity>();
  final box = GetStorage();

  RegisterController({
    required this.registerWithEmail,
  });

  final formKey = GlobalKey<FormState>();
  var obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
    update();
  }

  Future<void> register(String email, String password, String name) async {
    user.value = await registerWithEmail.call(email, password, name);
  }
}
