import 'package:dekaybaro/domain/core/AlamatRepository_impl.dart';
import 'package:get/get.dart';

import 'package:dekaybaro/domain/repositories/AlamatRepositories.dart';
import '../../../../presentation/customerpage/addalamat/controllers/addalamat.controller.dart';

class AddalamatControllerBinding extends Bindings {
  @override
  void dependencies() {
    // Assuming AddressRepositoryImpl is the concrete implementation of AddressRepository
    Get.lazyPut<AddressRepository>(() => AddressRepositoryImpl());

    Get.lazyPut<AddalamatController>(() {
      final addressRepository = Get.find<AddressRepository>();
      return AddalamatController(addressRepository);
    });
  }
}
