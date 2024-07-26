import 'dart:io';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakayu/controllers/datakayu.controller.dart';

class AddkayuView extends GetView<DatakayuController> {
  const AddkayuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kayu'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Foto',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildImagePicker(),
              const SizedBox(height: 16),
              _buildTextField('Nama Kayu', controller.nameController),
              _buildTextField('Deskripsi', controller.descriptionController,
                  maxLines: 3),
              _buildTextField('Stok', controller.stockController),
              _buildTextField('Kualitas', controller.qualityController),
              _buildTextField('Harga', controller.priceController),
              _buildCategoryDropdown(),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Obx(() => controller.imageFiles.isEmpty
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () => controller.pickImages(),
              child:
                  const Text('Pilih File', style: TextStyle(color: Colors.red)),
            ),
          )
        : Wrap(
            spacing: 10,
            runSpacing: 10,
            children: controller.imageFiles
                .map((file) => Image.file(
                      File(file.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ))
                .toList(),
          ));
  }

  Widget _buildTextField(String label, TextEditingController textController,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: textController,
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

  Widget _buildCategoryDropdown() {
    return Obx(() {
      final categories = controller.categories;
      final selectedCategory = controller.selectedCategory.value;

      // Memastikan selectedCategory selalu memiliki nilai yang valid.
      if (categories.isNotEmpty && !categories.contains(selectedCategory)) {
        controller.selectedCategory.value = categories.first;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: controller.selectedCategory.value.isNotEmpty
                ? controller.selectedCategory.value
                : null, // Set to null if no category is selected
            items: categories.map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (value) {
              if (value == 'Tambah Kategori Baru') {
                controller.isAddingNewCategory.value = true;
                controller.newCategoryController.clear();
                controller.selectedCategory.value = '';
              } else {
                controller.selectedCategory.value = value ?? '';
                controller.isAddingNewCategory.value = false;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Kategori',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          if (controller.isAddingNewCategory.value)
            _buildTextField('Kategori Baru', controller.newCategoryController),
        ],
      );
    });
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.addNewProduct(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.coklat7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: ReusableTextView(
              text: "Simpan", sizetext: 16, textcolor: AppColors.whiteColor),
        ),
      ),
    );
  }
}
