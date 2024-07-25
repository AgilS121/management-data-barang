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
    // Mengambil data produk dari arguments yang diteruskan
    final Product product = Get.arguments;

    print("cek image ${product.image[0]}");

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
            // Gambar produk
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
                    child: product.image.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              product.image[0],
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.lightGreen[100],
                                  child: Center(
                                    child: Text(
                                      '404',
                                      style: TextStyle(
                                        fontSize: 100,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green[800],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            color: Colors.lightGreen[100],
                            child: Center(
                              child: Text(
                                'No Image',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                          ),
                  ),
                  // Tombol favorite
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
            // Informasi produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.deskripsi!,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Stok"),
                      Text("${product.stok} / Blok"),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kualitas"),
                      Text(product.kualitas!),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Harga"),
                      Text("Rp ${product.price} / M"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Tombol untuk menghapus produk
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tampilkan dialog konfirmasi sebelum menghapus produk
          Get.dialog(
            AlertDialog(
              title: Text("Hapus Produk"),
              content: Text("Apakah Anda yakin ingin menghapus produk ini?"),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Batal"),
                ),
                TextButton(
                  onPressed: () async {
                    await controller.deleteProductById(product.id!);
                    Get.back();
                    Get.back();
                  },
                  child: Text("Hapus"),
                ),
              ],
            ),
          );
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
