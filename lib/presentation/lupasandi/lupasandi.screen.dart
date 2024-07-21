import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../infrastructure/theme/colors.dart';
import '../utils/views/reusable_button_view.dart';
import '../utils/views/reusable_text_field_view.dart';
import 'controllers/lupasandi.controller.dart';

class LupasandiScreen extends GetView<LupasandiController> {
  const LupasandiScreen({Key? key}) : super(key: key);
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
                  Get.toNamed('/login');
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
                      text: "Lupa Sandi",
                      sizetext: 24.sp,
                      textcolor: AppColors.coklat7,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    ReusableTextView(
                      text:
                          "Kami memerlukan akun Email pendaftaran Anda untuk mengirimkan mengatur ulang kode kata sandi",
                      sizetext: 14.sp,
                      textcolor: AppColors.blacktext,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50.h),
                    ReusableTextFieldView<LupasandiController>(
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
                    SizedBox(height: 20.h),
                    ReusableButtonView(
                      text: "Konfirmasi Email",
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
