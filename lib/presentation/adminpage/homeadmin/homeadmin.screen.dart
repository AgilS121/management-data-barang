import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/custom_bottom_navbar_admin_view.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/stock_product_card_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:dekaybaro/presentation/utils/views/welcome_header_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/homeadmin.controller.dart';

class HomeadminScreen extends GetView<HomeadminController> {
  const HomeadminScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            WelcomeHeaderView(name: "Jack Admin"),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Center(
                child: ReusableTextView(
                  text: "Semua Produk",
                  sizetext: 22,
                  textcolor: AppColors.blacktext,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ProductGridAdmin(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavbarAdminView(),
    );
  }
}

class ProductGridAdmin extends GetView<HomeadminController> {
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
            return StockProductCardView(product: controller.products[index]);
          },
        ));
  }
}
