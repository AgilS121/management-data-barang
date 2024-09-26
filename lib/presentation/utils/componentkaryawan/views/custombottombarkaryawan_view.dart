import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentkaryawan/controllers/custombottombarkaryawancontroller_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustombottombarkaryawanView
    extends GetView<CustombottombarkaryawancontrollerController> {
  const CustombottombarkaryawanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(CustombottombarkaryawancontrollerController());
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
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ));
  }
}
