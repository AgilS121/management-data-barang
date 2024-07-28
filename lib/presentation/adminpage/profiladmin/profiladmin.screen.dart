import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/custom_bottom_navbar_admin_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'controllers/profiladmin.controller.dart';

class ProfiladminScreen extends GetView<ProfiladminController> {
  const ProfiladminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableTextView(
          sizetext: 18,
          text: "Akun",
          fontWeight: FontWeight.bold,
          textcolor: AppColors.blacktext,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.user.value == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: controller.imageUrl.value.isNotEmpty
                        ? NetworkImage(controller.imageUrl.value)
                        : NetworkImage('https://via.placeholder.com/150'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showEditProfileDialog(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ReusableTextView(
                text: controller.name.value,
                sizetext: 16,
                fontWeight: FontWeight.bold,
                textcolor: AppColors.blacktext,
              ),
              SizedBox(height: 5),
              ReusableTextView(
                text: controller.email.value,
                sizetext: 14,
                textcolor: AppColors.greytext,
              ),
              SizedBox(height: 20),
              ListTile(
                leading: Icon(Icons.attach_money_rounded),
                title: Text('Pendapatan'),
                onTap: () => Get.toNamed("/pendapatan"),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Pengaturan'),
                onTap: () => Get.toNamed("/pengaturancustomer"),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Info'),
                onTap: () => Get.toNamed("/tentangaplikasi"),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Keluar'),
                onTap: () {
                  controller.signOut();
                  Get.offAllNamed("/login");
                },
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: CustomBottomNavbarAdminView(),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: controller.name.value);
    File? selectedImage;

    Get.dialog(
      AlertDialog(
        title: Text('Edit Profil'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Masukkan nama baru"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Pilih Gambar'),
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  selectedImage = File(image.path);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Batal'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Simpan'),
            onPressed: () {
              controller.updateProfile(nameController.text, selectedImage);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
