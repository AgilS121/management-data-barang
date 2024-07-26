import 'dart:io';

import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakayu/controllers/datakayu.controller.dart';

class EditkayuView extends StatelessWidget {
  final DatakayuController controller = Get.find();
  final Product product;

  EditkayuView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nameController.text = product.name;
    controller.descriptionController.text = product.deskripsi!;
    controller.stockController.text = product.stok.toString();
    controller.qualityController.text = product.kualitas!;
    controller.priceController.text = product.price.toString();

    // Mengisi imageUrls dengan URL gambar saat ini
    controller.imageUrls.assignAll(product.image);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kayu'),
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
              const Text('Foto',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildImagePicker(),
              buildImagePreview(),
              const SizedBox(height: 8),
              buildTextField('Nama Kayu', controller.nameController),
              buildTextField('Deskripsi', controller.descriptionController,
                  maxLines: 3),
              buildTextField('Stok / blok', controller.stockController),
              buildTextField('Kualitas', controller.qualityController),
              buildTextField('Harga', controller.priceController),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await controller.updateExistingProduct(Product(
                      id: product.id, // Gunakan ID produk yang ada untuk update
                      name: controller.nameController.text,
                      deskripsi: controller.descriptionController.text,
                      stok: int.parse(controller.stockController.text),
                      kualitas: controller.qualityController.text,
                      price: int.parse(controller.priceController.text),
                      image: controller.imageUrls, // Gambar yang diupdate
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.coklat7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: ReusableTextView(
                        text: "Simpan",
                        sizetext: 16,
                        textcolor: AppColors.whiteColor),
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
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
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

  Widget buildImagePreview() {
    return Obx(() {
      return controller.imageUrls.isEmpty
          ? Text('Tidak ada gambar')
          : Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: controller.imageUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.network(
                      url,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Center(child: Text('Gagal memuat gambar')),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            );
    });
  }
}
