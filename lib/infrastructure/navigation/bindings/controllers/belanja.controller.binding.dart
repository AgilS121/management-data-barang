import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../../domain/core/KategoriRepository_impl.dart';
import '../../../../domain/core/ProductRepository_impl.dart';
import '../../../../domain/usecase/KategoriUseCase.dart';
import '../../../../domain/usecase/ProductUseCase.dart';
import '../../../../presentation/customerpage/belanja/controllers/belanja.controller.dart';

class BelanjaControllerBinding extends Bindings {
  @override
  void dependencies() {
    final firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;

    // Register repositories
    final categoryRepository = CategoryRepositoryImpl(firestore);
    final productRepository = ProductRepositoryImpl(firestore, storage);

    // Register use cases
    Get.lazyPut(() => GetAllProducts(productRepository));
    Get.lazyPut(() => GetAllCategories(categoryRepository));

    // Register controller
    Get.lazyPut(() => BelanjaController(
          getAllProducts: Get.find(),
          getAllCategories: Get.find(),
        ));
  }
}
