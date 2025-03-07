import 'package:dekaybaro/domain/entities/StockFilter.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/customerpage/homecustomer/controllers/homecustomer.controller.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/category_tabs_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/custom_bottom_nav_bar_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/product_card_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/search_bar_view.dart';
import 'package:dekaybaro/presentation/utils/views/welcome_header_view.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeHeaderView(
              greeting: controller.getGreeting(),
              name: controller.userName,
            ),
            SearchBarView(),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCategoryChips(),
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

  Widget _buildCategoryChips() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(controller.categories.length, (index) {
            final isSelected = controller.selectedCategoryIndex.value == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ChoiceChip(
                label: Text(controller.categories[index]),
                selected: isSelected,
                onSelected: (_) => controller.selectCategory(index),
                selectedColor: AppColors.coklat7,
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            );
          }),
        ),
      );
    });
  }

  void _showStockFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Filter Stok'),
          children: [
            SimpleDialogOption(
              onPressed: () {
                controller.selectStockFilter(StockFilter.all);
                Get.back();
              },
              child: Text('Semua Stok'),
            ),
            SimpleDialogOption(
              onPressed: () {
                controller.selectStockFilter(StockFilter.zeroToMax);
                Get.back();
              },
              child: Text('Stok dari 0 ke ${controller.maxStock.value}'),
            ),
            SimpleDialogOption(
              onPressed: () {
                controller.selectStockFilter(StockFilter.maxToZero);
                Get.back();
              },
              child: Text('Stok dari ${controller.maxStock.value} ke 0'),
            ),
            SimpleDialogOption(
              onPressed: () {
                controller.selectStockFilter(StockFilter.onlyZero);
                Get.back();
              },
              child: Text('Hanya Stok 0'),
            ),
          ],
        );
      },
    );
  }
}

class ProductGrid extends GetView<HomecustomerController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(
          "Building grid with ${controller.filteredProducts.length} products"); // Add this line for debugging
      if (controller.filteredProducts.isEmpty) {
        return Center(
          child: Text(
            'Tidak ada produk untuk ditampilkan',
            style: TextStyle(fontSize: 16),
          ),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: controller.filteredProducts.length,
        itemBuilder: (context, index) {
          return ProductCardView(product: controller.filteredProducts[index]);
        },
      );
    });
  }
}
