import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/models/AlamatModel.dart';
import 'package:dekaybaro/domain/repositories/AlamatRepositories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddalamatController extends GetxController {
  final AddressRepository repository;
  AddalamatController(this.repository);

  // Observable list of addresses
  final RxList<Address> addresses = <Address>[].obs;

  // Form controllers and key
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final postalCodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Listen for real-time updates from Firestore
    _bindAddressStream();
  }

  void _bindAddressStream() {
    FirebaseFirestore.instance.collection('addresses').snapshots().listen(
      (querySnapshot) {
        addresses.assignAll(
          querySnapshot.docs
              .map((doc) => Address.fromJson(doc.data()))
              .toList(),
        );
      },
      onError: (error) {
        // Handle errors here if needed
      },
    );
  }

  void addAddress() async {
    if (formKey.currentState?.validate() ?? false) {
      final newAddress = Address(
        id: null, // Firestore will generate the ID
        name: nameController.text,
        phone: phoneController.text,
        street: streetController.text,
        city: cityController.text,
        postalCode: postalCodeController.text,
      );
      await repository.addAddress(newAddress);
      Get.back(); // Close the form screen
    }
  }

  void updateAddress(Address address) async {
    if (formKey.currentState?.validate() ?? false) {
      final updatedAddress = Address(
        id: address.id,
        name: nameController.text,
        phone: phoneController.text,
        street: streetController.text,
        city: cityController.text,
        postalCode: postalCodeController.text,
      );
      await repository.updateAddress(updatedAddress);
      Get.back(); // Close the form screen
    }
  }

  void deleteAddress(String id) async {
    await repository.deleteAddress(id);
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
    super.onClose();
  }
}
