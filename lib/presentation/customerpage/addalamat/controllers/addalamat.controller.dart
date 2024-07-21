import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddalamatController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  void addAddress() {
    final address =
        "${nameController.text}, ${phoneController.text}, ${addressController.text}";
    final productController =
        Get.find<ProductcardkeranjangcontrollerController>();
    productController.localAddress.value = address;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
