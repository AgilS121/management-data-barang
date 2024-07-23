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
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
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
                  ],
                ),
              ),
              // Kontrol jumlah dan hapus
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      Get.to(() => EditkayuView(), arguments: product);
                    },
                  ),
                  ReusableTextView(
                    text: product.stok.toString(),
                    sizetext: 16,
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
