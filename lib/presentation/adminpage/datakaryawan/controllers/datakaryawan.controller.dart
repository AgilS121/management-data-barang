import 'dart:io';

import 'package:dekaybaro/domain/models/KaryawanModel.dart';
import 'package:dekaybaro/domain/usecase/KaryawanUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DatakaryawanController extends GetxController {
  final RxList<KaryawanModel> karyawanItems = <KaryawanModel>[].obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final AddKaryawan addKaryawan;
  final GetAllKaryawan getAllKaryawan;
  final UpdateKaryawan updateKaryawan;
  final DeleteKaryawan deleteKaryawan;

  DatakaryawanController({
    required this.addKaryawan,
    required this.getAllKaryawan,
    required this.updateKaryawan,
    required this.deleteKaryawan,
  });

  final RxBool isFavorite = false.obs;
  final RxList<KaryawanModel> karyawanList = <KaryawanModel>[].obs;

  // TextEditingController for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final RxList<XFile> imageFiles = <XFile>[].obs;
  final RxList<String> imageUrls = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllKaryawan();
  }

  Future<void> fetchAllKaryawan() async {
    isLoading.value = true;
    final result = await getAllKaryawan();
    result.fold(
      (exception) {
        errorMessage.value = exception.toString();
      },
      (karyawanList) {
        karyawanItems.value = karyawanList;
      },
    );
    isLoading.value = false;
  }

  Future<void> addNewKaryawan() async {
    print("Tombol simpan diklik");
    isLoading.value = true;

    try {
      for (var imageFile in imageFiles) {
        String imageUrl = await uploadImageToStorage(imageFile);
        print("URL gambar: $imageUrl");
        imageUrls.add(imageUrl);
      }
    } catch (e) {
      print("Gagal mengunggah gambar: $e");
      errorMessage.value = 'Gagal mengunggah gambar: $e';
      isLoading.value = false;
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      KaryawanModel newKaryawan = KaryawanModel(
        id: userCredential.user!.uid,
        name: nameController.text,
        position: positionController.text,
        image: imageUrls.isNotEmpty ? imageUrls[0] : '',
        status: statusController.text,
        salary: salaryController.text,
        email: emailController.text,
        phone: phoneController.text,
        bio: bioController.text,
      );

      print("Data karyawan yang akan disimpan: ${newKaryawan.toJson()}");

      final result = await addKaryawan(newKaryawan);
      result.fold(
        (exception) {
          errorMessage.value = exception.toString();
          print("Gagal menyimpan karyawan: ${errorMessage.value}");
        },
        (karyawan) {
          karyawanItems.add(karyawan);
          print(
              "Karyawan berhasil disimpan: ${karyawan.name} dengan ID: ${karyawan.id}");

          resetForm();
          Get.back();
        },
      );
    } catch (e) {
      print("Terjadi kesalahan saat menyimpan karyawan: $e");
      errorMessage.value = 'Terjadi kesalahan saat menyimpan karyawan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void resetForm() {
    nameController.clear();
    positionController.clear();
    statusController.clear();
    emailController.clear();
    phoneController.clear();
    salaryController.clear();
    bioController.clear();
    imageFiles.clear();
    imageUrls.clear();
  }

  Future<void> updateExistingKaryawan(KaryawanModel karyawan) async {
    isLoading.value = true;

    try {
      if (imageFiles.isNotEmpty) {
        imageUrls.clear();
        for (var imageFile in imageFiles) {
          String imageUrl = await uploadImageToStorage(imageFile);
          imageUrls.add(imageUrl);
        }
      }

      KaryawanModel updatedKaryawan = karyawan.copyWith(
        name: nameController.text,
        position: positionController.text,
        image: imageUrls.isNotEmpty ? imageUrls[0] : karyawan.image,
        status: statusController.text,
        salary: salaryController.text,
        email: emailController.text,
        phone: phoneController.text,
        bio: bioController.text,
      );

      final result = await updateKaryawan(updatedKaryawan);
      result.fold(
        (exception) {
          errorMessage.value = exception.toString();
        },
        (updatedKaryawan) {
          int index =
              karyawanItems.indexWhere((p) => p.id == updatedKaryawan.id);
          if (index != -1) {
            karyawanItems[index] = updatedKaryawan;
          }
        },
      );
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan saat mengupdate karyawan: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> uploadImageToStorage(XFile imageFile) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageRef =
        FirebaseStorage.instance.ref().child('karyawan/$fileName');
    final UploadTask uploadTask = storageRef.putFile(File(imageFile.path));
    final TaskSnapshot downloadUrl = await uploadTask;
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  Future<void> deleteKaryawanById(String id) async {
    isLoading.value = true;

    final result = await deleteKaryawan(id);
    result.fold(
      (exception) {
        errorMessage.value = exception.toString();
      },
      (_) {
        karyawanItems.removeWhere((karyawan) => karyawan.id == id);
        print("Karyawan dengan ID $id berhasil dihapus.");
      },
    );

    isLoading.value = false;
  }

  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? selectedImages = await picker.pickMultiImage();

    if (selectedImages != null) {
      imageFiles.assignAll(selectedImages);
    }
  }
}
