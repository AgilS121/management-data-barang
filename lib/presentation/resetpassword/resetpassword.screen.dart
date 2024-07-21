import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../infrastructure/theme/colors.dart';
import '../utils/views/reusable_button_view.dart';
import '../utils/views/reusable_text_field_view.dart';
import '../utils/views/reusable_text_view.dart';
import 'controllers/resetpassword.controller.dart';

class ResetpasswordScreen extends GetView<ResetpasswordController> {
  const ResetpasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.blackColor),
                onPressed: () {
                  Get.toNamed('/onboarding');
                },
              ),
              backgroundColor: AppColors.whiteColor,
              expandedHeight: 100.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "UD PUTRA BAROKAH",
                  style: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ReusableTextView(
                      text: "Reset Sandi",
                      sizetext: 24.sp,
                      textcolor: AppColors.coklat7,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ReusableTextView(
                      text: "Buat kata sandi 8 digit yang kuat dengan simbol",
                      sizetext: 14.sp,
                      textcolor: AppColors.blacktext,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50.h),
                    ReusableTextFieldView<ResetpasswordController>(
                      label: 'Sandi',
                      hintText: 'Masukkan Sandi Anda',
                      icon: Icons.lock,
                      controller: controller.passwordController,
                      isPassword: true,
                      obscureText: controller.obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sandi tidak boleh kosong';
                        } else if (value.length < 8) {
                          return 'Sandi harus memiliki minimal 8 karakter';
                        }
                        return null;
                      },
                      onSuffixIconTap: controller.togglePasswordVisibility,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ReusableTextFieldView<ResetpasswordController>(
                      label: 'Konfirmasi Sandi',
                      hintText: 'Konfirmasi Sandi Anda',
                      icon: Icons.lock,
                      controller: controller.confirmPasswordController,
                      isPassword: true,
                      obscureText: controller.obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Konfirmasi sandi tidak boleh kosong';
                        } else if (value !=
                            controller.passwordController.text) {
                          return 'Konfirmasi sandi harus sama dengan sandi';
                        }
                        return null;
                      },
                      onSuffixIconTap: controller.togglePasswordVisibility,
                    ),
                    SizedBox(height: 20.h),
                    ReusableButtonView(
                      text: "Simpan",
                      sizetext: 24.sp,
                      widthbutton: 350.w,
                      colorbg: AppColors.brownColor,
                      colorfe: AppColors.whiteColor,
                      textcolor: AppColors.whiteColor,
                      onPressed: () {
                        controller.validateForm();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
