import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductCard extends GetWidget<ProductcardkeranjangcontrollerController> {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductcardkeranjangcontrollerController>(
      builder: (controller) {
        int quantity = controller.getQuantity(product);
        if (quantity == 0) {
          return SizedBox.shrink(); // Hapus kartu jika jumlah 0
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: product.image.isNotEmpty
                      ? Image.network(
                          product.image.first,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(
                                '404',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'Tidak Ada Gambar',
                            style: TextStyle(
                              fontSize: 16,
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => controller.removeItem(product),
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     IconButton(
                    //       icon: Icon(Icons.remove, size: 20),
                    //       onPressed: () => controller.decreaseQuantity(product),
                    //     ),
                    //     Text(
                    //       '$quantity',
                    //       style: TextStyle(fontSize: 16),
                    //     ),
                    //     IconButton(
                    //       icon: Icon(Icons.add, size: 20),
                    //       onPressed: () => controller.increaseQuantity(product),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
