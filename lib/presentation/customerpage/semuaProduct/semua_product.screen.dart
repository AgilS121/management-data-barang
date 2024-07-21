import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/custom_bottom_nav_bar_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/product_card_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/semua_product.controller.dart';

class SemuaProductScreen extends GetView<SemuaProductController> {
  const SemuaProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ReusableTextView(
          sizetext: 18,
          text: "Semua Produk",
          fontWeight: FontWeight.bold,
          textcolor: AppColors.blacktext,
        ),
        centerTitle: true,
      ),
      body: Expanded(
        child: ProductGridAll(),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class ProductGridAll extends GetView<SemuaProductController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return ProductCardView(product: controller.products[index]);
          },
        ));
  }
}
