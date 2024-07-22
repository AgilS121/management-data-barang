import 'package:get/get.dart';

class CustomBottomNavbarAdminControllerController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/homeadmin');
        break;
      case 1:
        Get.toNamed('/datakaryawan');
        break;
      case 2:
        Get.toNamed('/datakayu');
        break;
      case 3:
        Get.toNamed('/profiladmin');
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
