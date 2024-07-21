import 'package:get/get.dart';

class CustomBottomBarControllerController extends GetxController {
  //TODO: Implement CustomBottomBarControllerController

  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/homecustomer');
        break;
      case 1:
        Get.toNamed('/belanja');
        break;
      case 2:
        Get.toNamed('/keranjang');
        break;
      case 3:
        Get.toNamed('/akun');
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
