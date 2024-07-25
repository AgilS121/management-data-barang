import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/core/KaryawanRepository_impl.dart';
import 'package:dekaybaro/domain/usecase/KaryawanUseCase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../../../presentation/adminpage/datakaryawan/controllers/datakaryawan.controller.dart';

class DatakaryawanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DatakaryawanController(
          addKaryawan: AddKaryawan(Get.put(KaryawanrepositoryImpl(
              FirebaseFirestore.instance, FirebaseStorage.instance))),
          getAllKaryawan: GetAllKaryawan(Get.find()),
          updateKaryawan: UpdateKaryawan(Get.find()),
          deleteKaryawan: DeleteKaryawan(Get.find()),
        ));
  }
}
