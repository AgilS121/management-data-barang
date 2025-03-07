import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakaryawan/controllers/datakaryawan.controller.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddkaryawanView extends GetView<DatakaryawanController> {
  const AddkaryawanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Karyawan'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableTextView(
                text: "Profil",
                sizetext: 16,
                textcolor: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () async {
                    controller.pickImages(); // Pick images
                  },
                  child:
                      Text('Pilih File', style: TextStyle(color: Colors.red)),
                ),
              ),
              SizedBox(height: 16),
              buildTextField('Nama', controller.nameController),
              buildTextField('Telepon', controller.phoneController),
              buildTextField('Email', controller.emailController),
              buildTextField('Posisi', controller.positionController),
              buildTextField('Status', controller.statusController),
              buildTextField('Gaji', controller.salaryController),
              buildTextField('Bio', controller.bioController, maxLines: 3),
              buildTextField('Password', controller.passwordController,
                  obscureText: true), // Add password field
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.addNewKaryawan(); // Save new employee
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.coklat7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text('Simpan', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
