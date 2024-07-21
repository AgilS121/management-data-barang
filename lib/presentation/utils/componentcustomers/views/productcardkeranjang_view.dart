import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductCard extends GetView<ProductcardkeranjangcontrollerController> {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductcardkeranjangcontrollerController());
    return Obx(() {
      int quantity = controller.getQuantity(product);
      if (quantity == 0) {
        return SizedBox.shrink(); // Hapus card jika jumlah 0
      }
      return Card(
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
                    Text(
                      product.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rp ${NumberFormat("#,###").format(product.price)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                ),
              ),
              // Kontrol jumlah dan hapus
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.removeItem(product),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove, size: 20),
                          onPressed: () => controller.decreaseQuantity(product),
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          icon: Icon(Icons.add, size: 20),
                          onPressed: () => controller.increaseQuantity(product),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
