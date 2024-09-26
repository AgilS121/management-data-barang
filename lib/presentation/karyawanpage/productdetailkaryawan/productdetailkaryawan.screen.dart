// File: productdetailkaryawan_screen.dart

import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/productdetailkaryawan.controller.dart';

class ProductdetailkaryawanScreen
    extends GetView<ProductdetailkaryawanController> {
  const ProductdetailkaryawanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final productName = controller.product.value.name;
          return ReusableTextView(
            text: productName.isEmpty ? 'Produk Tidak Ditemukan' : productName,
            sizetext: 20,
            textcolor: AppColors.blacktext,
            fontWeight: FontWeight.bold,
          );
        }),
      ),
      body: Obx(() {
        final product = controller.product.value;

        if (product.name.isEmpty) {
          return Center(child: Text('Produk tidak ditemukan'));
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: PageView.builder(
                  onPageChanged: controller.selectImage,
                  itemCount: product.image.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      product.image[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  product.image.length,
                  (index) => GestureDetector(
                    onTap: () => controller.selectImage(index),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: controller.selectedImageIndex.value == index
                              ? Colors.brown
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          product.image[index],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ReusableTextView(
                            text: product.name,
                            sizetext: 18,
                            textcolor: AppColors.blacktext,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ReusableTextView(
                          text: product.adalahKayuGelondongan ?? false
                              ? 'Rp ${product.price.toString()} / m³'
                              : 'Rp ${product.price.toString()}',
                          sizetext: 18,
                          textcolor: AppColors.blacktext,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    ReusableTextView(
                      text: "Deskripsi",
                      sizetext: 18,
                      textcolor: AppColors.blacktext,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8),
                    ReusableTextView(
                        text: product.deskripsi ?? "Tidak ada deskripsi",
                        sizetext: 14,
                        textcolor: AppColors.greytext),
                    SizedBox(height: 16),
                    ReusableTextView(
                      text: 'Jenis Kayu:',
                      sizetext: 18,
                      textcolor: AppColors.blacktext,
                      fontWeight: FontWeight.bold,
                    ),
                    ReusableTextView(
                        text: product.jenisKayu ?? 'Tidak tersedia',
                        sizetext: 18,
                        textcolor: AppColors.greytext),
                    SizedBox(height: 8),
                    ReusableTextView(
                      text: 'Kualitas Kayu:',
                      sizetext: 18,
                      textcolor: AppColors.blacktext,
                      fontWeight: FontWeight.bold,
                    ),
                    ReusableTextView(
                        text: product.kualitas ?? 'Tidak tersedia',
                        sizetext: 18,
                        textcolor: AppColors.greytext),
                    SizedBox(height: 8),
                    ReusableTextView(
                      text: 'Stok Kayu:',
                      sizetext: 18,
                      textcolor: AppColors.blacktext,
                      fontWeight: FontWeight.bold,
                    ),
                    ReusableTextView(
                        text: product.stok.toString() ?? "0",
                        sizetext: 18,
                        textcolor: AppColors.greytext),
                    SizedBox(height: 24),
                    Row(
                      children: [
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (product.stok != null &&
                                    product.stok! < 3 &&
                                    !controller.isAddingToCart.value)
                                ? () async {
                                    await controller.remindToAddStock();
                                  }
                                : null,
                            child: controller.isAddingToCart.value
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : ReusableTextView(
                                    text: "Ingatkan Untuk Menambah Stok",
                                    sizetext: 14,
                                    textcolor: AppColors.whiteColor),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.coklat7,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
