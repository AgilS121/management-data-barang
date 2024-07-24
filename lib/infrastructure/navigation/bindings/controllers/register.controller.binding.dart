import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/core/AuthRepository_impl.dart';
import 'package:dekaybaro/domain/repositories/AuthRepositories.dart';
import 'package:dekaybaro/domain/usecase/RegisterEmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../presentation/register/controllers/register.controller.dart';

class RegisterControllerBinding extends Bindings {
  @override
  void dependencies() {
    final firebaseAuth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();
    final firestore = FirebaseFirestore.instance;

    Get.lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(firebaseAuth, googleSignIn, firestore));
    Get.lazyPut(() => RegisterWithEmail(Get.find<AuthRepository>()));

    Get.lazyPut(() => RegisterController(registerWithEmail: Get.find()));
  }
}
