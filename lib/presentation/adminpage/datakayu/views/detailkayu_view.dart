import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakayu/controllers/datakayu.controller.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailkayuView extends GetView<DatakayuController> {
  const DetailkayuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengambil data produk dari arguments yang diteruskan
    final Product product = Get.arguments;

    // Index dari gambar yang dipilih
    RxInt selectedImageIndex = 0.obs;

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300.h,
                width: double.infinity,
                child: PageView.builder(
                  onPageChanged: (index) {
                    selectedImageIndex.value = index;
                  },
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
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    product.image.length,
                    (index) => GestureDetector(
                      onTap: () {
                        selectedImageIndex.value = index;
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: selectedImageIndex.value == index
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
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
                          text: product.name,
                          sizetext: 18,
                          textcolor: AppColors.blacktext,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 8),
                        ReusableTextView(
                          text: product.adalahKayuGelondongan!
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
                      textcolor: AppColors.greytext,
                    ),
                    SizedBox(height: 16),
                    ReusableTextView(
                      text: 'Jenis Kayu:',
                      sizetext: 18,
                      textcolor: AppColors.blacktext,
                      fontWeight: FontWeight.bold,
                    ),
                    ReusableTextView(
                      text: ' ${product.jenisKayu}',
                      sizetext: 18,
                      textcolor: AppColors.greytext,
                    ),
                    ReusableTextView(
                      text: 'Kualitas:',
                      sizetext: 18,
                      textcolor: AppColors.blacktext,
                      fontWeight: FontWeight.bold,
                    ),
                    ReusableTextView(
                      text: '${product.kualitas}',
                      sizetext: 18,
                      textcolor: AppColors.greytext,
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              )
            ],
          ),
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
