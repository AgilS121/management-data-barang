import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/usecase/LoginEmail.dart';
import 'package:dekaybaro/domain/usecase/LoginGoogle.dart';
import 'package:dekaybaro/domain/usecase/Logout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginWithEmail loginWithEmail;
  final LoginWithGoogle loginWithGoogle;
  final Logout logout;
  var user = Rxn<UserEntity>();

  LoginController({
    required this.loginWithEmail,
    required this.loginWithGoogle,
    required this.logout,
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

  Future<void> signOut() async {
    await logout.call();
    user.value = null;
  }
}
