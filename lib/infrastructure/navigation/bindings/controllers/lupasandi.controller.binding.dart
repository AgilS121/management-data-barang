import 'package:get/get.dart';

import '../../../../presentation/lupasandi/controllers/lupasandi.controller.dart';

class LupasandiControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LupasandiController>(
      () => LupasandiController(),
    );
  }
}
