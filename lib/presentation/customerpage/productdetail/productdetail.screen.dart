import 'package:dekaybaro/presentation/customerpage/productdetail/controllers/productdetail.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';

class ProductdetailScreen extends GetView<ProductdetailController> {
  const ProductdetailScreen({Key? key}) : super(key: key);

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
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isFavorite.value
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: controller.isFavorite.value ? Colors.red : null,
                ),
                onPressed: controller.toggleFavorite,
              )),
          Obx(() => Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Get.toNamed('/keranjang');
                    },
                  ),
                  if (controller.cartItemCount.value > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${controller.cartItemCount.value}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              )),
        ],
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
                    SizedBox(height: 24),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  if (controller.quantity.value > 1) {
                                    controller.quantity.value--;
                                  }
                                },
                              ),
                              Obx(
                                () => Text(
                                  controller.quantity.value.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  controller.quantity.value++;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controller.isAddingToCart.value
                                ? null
                                : () async {
                                    await controller.addToCart();
                                  },
                            child: controller.isAddingToCart.value
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                : ReusableTextView(
                                    text: "Tambah ke Keranjang",
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
