import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/usecase/Logout.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfiladminController extends GetxController {
  final Logout logout;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString imageUrl = ''.obs;

  ProfiladminController({required this.logout});

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String userId = currentUser.email ?? '';
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          name.value = userData['name'] ?? 'No Name';
          email.value = userData['email'] ?? 'No Email';
          imageUrl.value = userData['imageUrl'] ?? '';
          user.value = UserEntity(
            id: userId,
            email: email.value,
            name: name.value,
            role: userData['role'] ?? 'customers',
          );
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> signOut() async {
    await logout.call();
    user.value = null;
  }

  Future<void> updateProfile(String newName, File? imageFile) async {
    try {
      String userId = user.value?.id ?? '';
      Map<String, dynamic> updateData = {'name': newName};

      if (imageFile != null) {
        String imageUrl = await _uploadImage(imageFile, userId);
        updateData['imageUrl'] = imageUrl;
        this.imageUrl.value = imageUrl;
      }

      await _firestore.collection('users').doc(userId).update(updateData);
      name.value = newName;
      Get.snackbar('Sukses', 'Profil berhasil diperbarui');
    } catch (e) {
      print('Error updating profile: $e');
      Get.snackbar('Error', 'Gagal memperbarui profil');
    }
  }

  Future<String> _uploadImage(File imageFile, String userId) async {
    try {
      Reference ref = _storage.ref().child('profile_images').child(userId);
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
}
