import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LupasandiController extends GetxController {
  final emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var obscureText = true.obs;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
    update();
  }

  void validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      Get.snackbar('Success', 'Form is valid');
      Get.toNamed("/resetpassword");
    } else {
      Get.defaultDialog(
        title: 'Invalid Input',
        middleText: 'Please fill in all fields correctly.',
        textConfirm: 'OK',
        onConfirm: () => Get.back(),
      );
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
