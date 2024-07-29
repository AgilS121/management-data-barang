import 'package:dekaybaro/presentation/customerpage/keranjang/controllers/keranjang.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeranjangScreen extends GetView<KeranjangController> {
  const KeranjangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.cartItems.isEmpty) {
          return Center(child: Text('Keranjang anda kosong'));
        }

        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (context, index) {
            final product = controller.cartItems[index];
            return ListTile(
              leading: Image.network(product.image[0]),
              title: Text(product.name),
              subtitle: Text('Rp ${product.price}'),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => controller.increaseQuantity(product),
                  ),
                  Text('${controller.getQuantity(product)}'),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => controller.decreaseQuantity(product),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
