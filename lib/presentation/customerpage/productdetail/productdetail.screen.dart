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
        title: ReusableTextView(
          text: controller.product.name,
          sizetext: 20,
          textcolor: AppColors.blacktext,
          fontWeight: FontWeight.bold,
        ),
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
                      // Navigate to cart screen
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Column(
                    children: [
                      Container(
                        height: 300.h,
                        width: double.infinity,
                        child: PageView.builder(
                          onPageChanged: controller.selectImage,
                          itemCount: controller.product.image.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              controller.product.image[index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          controller.product.image.length,
                          (index) => GestureDetector(
                            onTap: () => controller.selectImage(index),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4.0),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors
                                    .white, // Background color for better shadow effect
                                border: Border.all(
                                  color: controller.selectedImageIndex.value ==
                                          index
                                      ? Colors.brown
                                      : Colors.grey,
                                ),
                                borderRadius:
                                    BorderRadius.circular(8.0), // Rounded edges
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.2), // Shadow color
                                    spreadRadius: 1, // Spread radius
                                    blurRadius: 5, // Blur radius
                                    offset: Offset(
                                        0, 3), // Offset in x and y direction
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Ensure image corners match container
                                child: Image.network(
                                  controller.product.image[index],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableTextView(
                          text: controller.product.name,
                          sizetext: 18,
                          textcolor: AppColors.blacktext,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8),
                        ReusableTextView(
                          text: controller.product.adalahKayuGelondongan!
                              ? 'Rp ${controller.product.price.toString()} / m³'
                              : 'Rp ${controller.product.price.toString()}',
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
                        text: controller.product.deskripsi ??
                            "Tidak ada deskripsi",
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
                        text: ' ${controller.product.jenisKayu}',
                        sizetext: 18,
                        textcolor: AppColors.greytext),
                    ReusableTextView(
                      text: 'Jenis Kayu:',
                      sizetext: 18,
                      textcolor: AppColors.blacktext,
                      fontWeight: FontWeight.bold,
                    ),
                    ReusableTextView(
                        text: '${controller.product.kualitas}',
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
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Obx(() => IconButton(
                                icon: controller.isAddingToCart.value
                                    ? CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.black),
                                      )
                                    : Icon(Icons.shopping_cart,
                                        color: Colors.black),
                                onPressed: controller.isAddingToCart.value
                                    ? null
                                    : controller.addToCart,
                              )),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Logika untuk beli sekarang
                            },
                            child: Text(
                              'Beli Sekarang',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
