import 'package:cloud_firestore/cloud_firestore.dart';
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
    try {
      user.value = await loginWithEmail.call(email, password);
      if (user.value != null) {
        // Get user role and navigate to the appropriate home page
        await _navigateBasedOnRole(user.value!.id);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> loginWithGoogleAccount() async {
    try {
      user.value = await loginWithGoogle.call();
      if (user.value != null) {
        // Get user role and navigate to the appropriate home page
        await _navigateBasedOnRole(user.value!.id);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> _navigateBasedOnRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      String role = userDoc['role'] ?? 'customers';
      switch (role) {
        case 'admin':
          Get.offAllNamed('/homeadmin');
          break;
        case 'karyawan':
          Get.offAllNamed('/homekaryawan');
          break;
        default:
          Get.offAllNamed('/homecustomer');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get user role');
    }
  }
}
