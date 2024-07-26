import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/usecase/LoginEmail.dart';
import 'package:dekaybaro/domain/usecase/LoginGoogle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginWithEmail loginWithEmail;
  final LoginWithGoogle loginWithGoogle;
  var user = Rxn<UserEntity>();

  LoginController({
    required this.loginWithEmail,
    required this.loginWithGoogle,
  });

  final formKey = GlobalKey<FormState>();
  var obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
    update();
  }

  Future<void> login(String email, String password) async {
    user.value = await loginWithEmail.call(email, password);
  }

  Future<void> loginWithGoogleAccount() async {
    user.value = await loginWithGoogle.call();
  }
}
