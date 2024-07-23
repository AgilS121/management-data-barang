import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakayu/controllers/datakayu.controller.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailkayuView extends GetView<DatakayuController> {
  const DetailkayuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(DatakayuController());
    final Product product = Get.arguments;
    print("data kayu ${product.image} ${product.name}");

    return Scaffold(
      appBar: AppBar(
        title: ReusableTextView(
          text: "Detail Kayu",
          sizetext: 20,
          textcolor: AppColors.blacktext,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.lightGreen[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "404",
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Obx(() => IconButton(
                          icon: Icon(
                            controller.isFavorite.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.isFavorite.value
                                ? Colors.red
                                : Colors.white,
                          ),
                          onPressed: () {
                            controller.isFavorite.toggle();
                          },
                        )),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kayu Alba",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Lorem Ipsum Dolor sit amet",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Stok"),
                      Text("60 / Blok"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kualitas"),
                      Text("Bagus"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Harga"),
                      Text("700.000/M"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logika ketika tombol ditekan
        },
        backgroundColor: AppColors.whiteColor,
        child: Icon(
          Icons.delete,
          color: AppColors.coklat7,
        ),
      ),
    );
  }
}
