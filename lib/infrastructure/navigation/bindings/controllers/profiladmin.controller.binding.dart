import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/core/AuthRepository_impl.dart';
import 'package:dekaybaro/domain/repositories/AuthRepositories.dart';
import 'package:dekaybaro/domain/usecase/Logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../presentation/adminpage/profiladmin/controllers/profiladmin.controller.dart';

class ProfiladminControllerBinding extends Bindings {
  @override
  void dependencies() {
    final firestore = FirebaseFirestore.instance;
    final firebaseAuth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();

    final logoutcategory =
        AuthRepositoryImpl(firebaseAuth, googleSignIn, firestore);

    // Register controller
    Get.lazyPut(() => ProfiladminController(
          logout: Logout(logoutcategory),
        ));
  }
}
