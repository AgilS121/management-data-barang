import 'package:dekaybaro/presentation/adminpage/datakaryawan/controllers/datakaryawan.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/domain/models/KaryawanModel.dart';

class EditkaryawanView extends GetView<DatakaryawanController> {
  final KaryawanModel karyawan;

  EditkaryawanView({Key? key, required this.karyawan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nameController.text = karyawan.name!;
    controller.phoneController.text = karyawan.phone!;
    controller.emailController.text = karyawan.email!;
    controller.positionController.text = karyawan.position!;
    controller.statusController.text = karyawan.status!;
    controller.salaryController.text = karyawan.salary!;
    controller.bioController.text = karyawan.bio!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Karyawan'),
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
              Text('Profil',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
              // Display existing images if available
              if (karyawan.image!.isNotEmpty) ...[
                Image.network(
                  karyawan.image!, // Directly use the image URL string
                  height: 100,
                  width: 100,
                ),
                SizedBox(height: 16),
              ],
              buildTextField('Nama', controller.nameController),
              buildTextField('Telepon', controller.phoneController),
              buildTextField('Email', controller.emailController),
              buildTextField('Posisi', controller.positionController),
              buildTextField('Status', controller.statusController),
              buildTextField('Gaji', controller.salaryController),
              buildTextField('Bio', controller.bioController, maxLines: 3),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.updateExistingKaryawan(karyawan);
                    Get.back();
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
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
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
