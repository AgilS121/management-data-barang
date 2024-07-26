import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/core/KategoriRepository_impl.dart';
import 'package:dekaybaro/domain/core/ProductRepository_impl.dart';
import 'package:dekaybaro/domain/usecase/KategoriUseCase.dart';
import 'package:dekaybaro/domain/usecase/ProductUseCase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../../presentation/adminpage/homeadmin/controllers/homeadmin.controller.dart';

class HomeadminControllerBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize Firebase instances
    final firestore = FirebaseFirestore.instance;
    final storage = FirebaseStorage.instance;

    // Register repositories
    final categoryRepository = CategoryRepositoryImpl(firestore);
    final productRepository = ProductRepositoryImpl(firestore, storage);

    // Register use cases
    Get.lazyPut(() => GetAllProducts(productRepository));
    Get.lazyPut(() => GetAllCategories(categoryRepository));

    // Register controller
    Get.lazyPut(() => HomeadminController(
          getAllProducts: Get.find(),
          getAllCategories: Get.find(),
        ));
  }
}
