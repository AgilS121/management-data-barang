import 'package:get/get.dart';

import '../../../../presentation/resetpassword/controllers/resetpassword.controller.dart';

class ResetpasswordControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetpasswordController>(
      () => ResetpasswordController(),
    );
  }
}
