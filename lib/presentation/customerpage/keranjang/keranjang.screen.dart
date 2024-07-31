import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_button_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dekaybaro/presentation/customerpage/keranjang/controllers/keranjang.controller.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/custom_bottom_nav_bar_view.dart';

class KeranjangScreen extends GetView<KeranjangController> {
  const KeranjangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableTextView(
          sizetext: 18,
          text: "Keranjang",
          fontWeight: FontWeight.bold,
          textcolor: AppColors.blacktext,
        ),
        centerTitle: true,
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
            return Dismissible(
              key: Key(product.id.toString()),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                controller.removeItem(product);
              },
              child: Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: product.image.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product.image.first,
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
                  title: Text(product.name),
                  subtitle: Text('Rp ${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => controller.decreaseQuantity(product),
                      ),
                      Text('${product.stok ?? 0}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => controller.increaseQuantity(product),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ReusableButtonView(
            text: "Beli Langsung",
            sizetext: 16,
            colorbg: AppColors.whiteColor,
            colorfe: AppColors.whiteColor,
            textcolor: AppColors.coklat6,
            onPressed: () {
              if (controller.cartItems.isNotEmpty) {
                Get.toNamed("/pembayaran",
                    arguments: controller.cartItems.toList());
              } else {
                // Show a message that the cart is empty
                Get.snackbar('Keranjang Kosong',
                    'Tambahkan produk ke keranjang terlebih dahulu.');
              }
            },
            widthbutton: 350.w,
          ),
          CustomBottomNavBar(),
        ],
      ),
    );
  }
}
