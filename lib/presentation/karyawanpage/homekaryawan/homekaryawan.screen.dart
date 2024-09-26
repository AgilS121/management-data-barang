import 'package:dekaybaro/domain/entities/StockFilter.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/screens.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/stock_product_card_view.dart';
import 'package:dekaybaro/presentation/utils/componentkaryawan/views/PembelianCard.dart';
import 'package:dekaybaro/presentation/utils/componentkaryawan/views/PembelianDetail.dart';
import 'package:dekaybaro/presentation/utils/componentkaryawan/views/custombottombarkaryawan_view.dart';
import 'package:dekaybaro/presentation/utils/componentkaryawan/views/stockproduct_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:dekaybaro/presentation/utils/views/welcome_header_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/homekaryawan.controller.dart';

class HomekaryawanScreen extends GetView<HomekaryawanController> {
  const HomekaryawanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeHeaderView(
              greeting: "Selamat Datang",
              name: 'karyawan',
            ),
            _buildNavBar(),
            Expanded(
              child: Obx(() {
                return controller.currentTab.value == 0
                    ? _buildProductsContent(context)
                    : _buildTransactionsContent(context);
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustombottombarkaryawanView(),
    );
  }

  Widget _buildNavBar() {
    return Obx(() => Row(
          children: [
            Expanded(
              child: _buildNavBarItem("Semua Produk", 0),
            ),
            Expanded(
              child: _buildNavBarItem("Semua Transaksi", 1),
            ),
          ],
        ));
  }

  Widget _buildNavBarItem(String title, int index) {
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: controller.currentTab.value == index
                  ? AppColors.coklat7
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: controller.currentTab.value == index
                ? AppColors.coklat7
                : AppColors.blacktext,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProductsContent(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableTextView(
                    text: "Semua Produk",
                    sizetext: 22,
                    textcolor: AppColors.blacktext,
                    fontWeight: FontWeight.bold,
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () {
                      _showStockFilterDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildCategoryChips(),
            ],
          ),
        ),
        Expanded(child: ProductGridKaryawan()),
      ],
    );
  }

  Widget _buildTransactionsContent(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.purchases.isEmpty) {
        return Center(child: Text('Tidak ada transaksi untuk ditampilkan'));
      } else {
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.purchases.length,
          itemBuilder: (context, index) {
            final purchase = controller.purchases[index];
            return PurchaseCard(
              purchase: purchase,
              userName: purchase.userName!,
              image: purchase.image!,
              onTap: () =>
                  Get.to(() => PurchaseDetailScreen(purchase: purchase)),
            );
          },
        );
      }
    });
  }

  Widget _buildCategoryChips() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
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

class ProductGridKaryawan extends GetView<HomekaryawanController> {
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
          return StockproductView(product: controller.filteredProducts[index]);
        },
      );
    });
  }
}
