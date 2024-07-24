import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/core/ProductRepository_impl.dart';
import 'package:dekaybaro/domain/usecase/ProductUseCase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../../presentation/adminpage/datakayu/controllers/datakayu.controller.dart';

class DatakayuControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DatakayuController(
          addProduct: AddProduct(Get.put(ProductRepositoryImpl(
              FirebaseFirestore.instance, FirebaseStorage.instance))),
          getAllProducts: GetAllProducts(Get.find()),
          updateProduct: UpdateProduct(Get.find()),
          deleteProduct: DeleteProduct(Get.find()),
        ));
  }
}
