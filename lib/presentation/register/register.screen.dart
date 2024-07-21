import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../utils/views/customdivider_view.dart';
import '../utils/views/reusable_button_view.dart';
import '../utils/views/reusable_text_field_view.dart';
import '../utils/views/reusable_text_view.dart';
import 'controllers/register.controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

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
                      text: "Daftar Akun",
                      sizetext: 24.sp,
                      textcolor: AppColors.blackColor,
                    ),
                    SizedBox(height: 50.h),
                    ReusableTextFieldView<RegisterController>(
                      label: 'Nama',
                      hintText: 'Masukkan Nama Anda',
                      icon: Icons.person,
                      isPassword: false,
                      controller: controller.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        }
                        return null;
                      },
                      obscureText: false.obs,
                    ),
                    SizedBox(height: 10.h),
                    ReusableTextFieldView<RegisterController>(
                      label: 'Email',
                      hintText: 'Masukkan Email Anda',
                      icon: Icons.email,
                      isPassword: false,
                      controller: controller.emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        } else if (!GetUtils.isEmail(value)) {
                          return 'Email tidak valid';
                        }
                        return null;
                      },
                      obscureText: false.obs,
                    ),
                    SizedBox(height: 10.h),
                    ReusableTextFieldView<RegisterController>(
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
                    SizedBox(height: 20.h),
                    ReusableButtonView(
                      text: "Daftar",
                      sizetext: 24.sp,
                      widthbutton: 350.w,
                      colorbg: AppColors.brownColor,
                      colorfe: AppColors.whiteColor,
                      textcolor: AppColors.whiteColor,
                      onPressed: () {
                        controller.validateForm();
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomdividerView(),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () {
                        // Implementasi login dengan Google
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/google.png', // path logo Google
                              height: 24.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Sudah Mempunyai Akun? "),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/login");
                            },
                            child: Text("Masuk"),
                          )
                        ],
                      ),
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
