import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakayu/views/detailkayu_view.dart';
import 'package:dekaybaro/presentation/adminpage/datakayu/views/editkayu_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardKayuView extends GetView {
  final Product product;

  const CardKayuView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("data image ${product.image}");
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailkayuView(), arguments: product);
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              // Gambar produk
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: product.image.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.image[0],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.lightBlue[50],
                              child: Center(
                                child: Text(
                                  '404',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        color: Colors.lightBlue[50],
                        child: Center(
                          child: Text(
                            'No Image',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(width: 16),
              // Informasi produk
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableTextView(
                      text: product.name,
                      sizetext: 20,
                      textcolor: AppColors.blackColor,
                    ),
                    SizedBox(height: 4),
                    ReusableTextView(
                      text: 'Rp ${product.price}',
                      sizetext: 16,
                      textcolor: AppColors.greytext,
                    ),
                  ],
                ),
              ),
              // Kontrol jumlah dan edit
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      Get.to(
                          () => EditkayuView(
                                product: product,
                              ),
                          arguments: product);
                    },
                  ),
                  ReusableTextView(
                    text: 'Stok: ${product.stok}',
                    sizetext: 14,
                    textcolor: AppColors.greytext,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
