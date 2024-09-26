import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/core/AuthRepository_impl.dart';
import 'package:dekaybaro/domain/usecase/Logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../presentation/karyawanpage/profilekaryawan/controllers/profilekaryawan.controller.dart';

class ProfilekaryawanControllerBinding extends Bindings {
  @override
  void dependencies() {
    final firestore = FirebaseFirestore.instance;
    final firebaseAuth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();

    final logoutcategory =
        AuthRepositoryImpl(firebaseAuth, googleSignIn, firestore);

    // Register controller
    Get.lazyPut(() => ProfilekaryawanController(
          logout: Logout(logoutcategory),
        ));
  }
}
