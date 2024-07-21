import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/controllers/custom_bottom_navbar_admin_controller_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomBottomNavbarAdminView
    extends GetView<CustomBottomNavbarAdminControllerController> {
  const CustomBottomNavbarAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(CustomBottomNavbarAdminControllerController());
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
              icon: Icon(Icons.people),
              label: 'Karyawan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forest),
              label: 'Kayu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ));
  }
}
