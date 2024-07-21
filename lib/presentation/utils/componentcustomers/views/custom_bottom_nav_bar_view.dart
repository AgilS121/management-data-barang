import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/custom_bottom_bar_controller_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomBottomNavBar extends GetView<CustomBottomBarControllerController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CustomBottomBarControllerController());
    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.coklat7,
          unselectedItemColor: AppColors.bottominactive,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Belanja',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Keranjang',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ));
  }
}
