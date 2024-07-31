import 'package:dekaybaro/domain/core/AlamatRepository_impl.dart';
import 'package:dekaybaro/domain/core/PembelianRepository_impl.dart';
import 'package:dekaybaro/domain/repositories/AlamatRepositories.dart';
import 'package:dekaybaro/domain/repositories/BayarRepositories.dart';
import 'package:dekaybaro/domain/usecase/PembelianUseCase.dart';
import 'package:dekaybaro/presentation/customerpage/pembayaran/controllers/pembayaran.controller.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:get/get.dart';

class PembayaranControllerBinding extends Bindings {
  @override
  void dependencies() {
    // Register repositories
    Get.lazyPut<AddressRepository>(() => AddressRepositoryImpl());
    Get.lazyPut<PurchaseRepository>(() => PurchaseRepositoryImpl());

    // Register use cases
    Get.lazyPut(() => GetPurchases(Get.find()));
    Get.lazyPut(() => AddPurchase(Get.find()));
    Get.lazyPut(() => UpdatePurchase(Get.find()));
    Get.lazyPut(() => DeletePurchase(Get.find()));
    Get.lazyPut(() => GetPurchaseById(Get.find()));

    // Register the controller with the necessary dependencies
    Get.put(
      PembayaranController(
        addressRepository: Get.find(),
        createPurchaseUseCase: Get.find(),
        getPurchaseByIdUseCase: Get.find(),
        getAllPurchasesUseCase: Get.find(),
        deletePurchaseUseCase: Get.find(),
      ),
    );

    // Register other controllers
    Get.lazyPut<ProductcardkeranjangcontrollerController>(
      () => ProductcardkeranjangcontrollerController(),
    );
  }
}
