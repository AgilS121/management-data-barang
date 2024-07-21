import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/customerpage/homecustomer/controllers/homecustomer.controller.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/category_tabs_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/custom_bottom_nav_bar_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/product_card_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/search_bar_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/welcome_header_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomecustomerScreen extends GetView<HomecustomerController> {
  const HomecustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            WelcomeHeaderView(name: "Jack"),
            SearchBarView(),
            CategoryTabs(),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableTextView(
                    text: "Semua Produk",
                    sizetext: 22,
                    textcolor: AppColors.blacktext,
                    fontWeight: FontWeight.bold,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/semua-product");
                    },
                    child: Row(
                      children: [
                        ReusableTextView(
                            text: "Lihat Semua",
                            sizetext: 13,
                            textcolor: AppColors.greytext),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_right_alt),
                          color: AppColors.greytext,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ProductGrid(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

class CategoryTabs extends GetView<HomecustomerController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              controller.categories.length,
              (index) => CategoryTabsView(
                text: controller.categories[index],
                isSelected: controller.selectedCategoryIndex.value == index,
                onTap: () => controller.selectCategory(index),
              ),
            ),
          ),
        ));
  }
}

class ProductGrid extends GetView<HomecustomerController> {
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
