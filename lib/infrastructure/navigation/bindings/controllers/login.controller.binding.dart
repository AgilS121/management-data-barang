import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/core/AuthRepository_impl.dart';
import 'package:dekaybaro/domain/repositories/AuthRepositories.dart';
import 'package:dekaybaro/domain/usecase/LoginEmail.dart';
import 'package:dekaybaro/domain/usecase/LoginGoogle.dart';
import 'package:dekaybaro/domain/usecase/Logout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../presentation/login/controllers/login.controller.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    final firebaseAuth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();
    final firestore = FirebaseFirestore.instance;

    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(firebaseAuth, googleSignIn, firestore));
    Get.lazyPut(() => LoginWithEmail(Get.find()));
    Get.lazyPut(() => LoginWithGoogle(Get.find()));
    Get.lazyPut(() => Logout(Get.find()));

    Get.lazyPut(() => LoginController(
          loginWithEmail: Get.find(),
          loginWithGoogle: Get.find(),
        ));
  }
}
