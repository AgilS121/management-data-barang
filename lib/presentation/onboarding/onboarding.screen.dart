import 'package:dekaybaro/presentation/utils/views/reusable_button_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/onboarding.controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 690));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ReusableTextView(
              text: "UD PUTRA BAROKAH",
              sizetext: 24.sp,
              textcolor: AppColors.blackColor,
            ),
            SizedBox(height: 50.h),
            ReusableButtonView(
              onPressed: () {
                Get.toNamed("/login");
              },
              widthbutton: 300.w,
              text: "Lanjutkan Sebagai Tamu",
              sizetext: 18.sp,
              colorbg: AppColors.brownColor,
              colorfe: AppColors.whiteColor,
              textcolor: AppColors.whiteColor,
            ),
            SizedBox(height: 20.h),
            ReusableButtonView(
              widthbutton: 300.w,
              onPressed: () {
                Get.toNamed("/register");
              },
              text: "Daftar Akun",
              sizetext: 18.sp,
              colorbg: AppColors.whiteColor,
              colorfe: AppColors.brownColor,
              textcolor: AppColors.brownColor,
            ),
            SizedBox(height: 20.h),
            ReusableButtonView(
              widthbutton: 300.w,
              onPressed: () {
                Get.toNamed("/login");
              },
              text: "Masuk",
              sizetext: 18.sp,
              colorbg: AppColors.whiteColor,
              colorfe: AppColors.brownColor,
              textcolor: AppColors.brownColor,
            ),
          ],
        ),
      ),
    );
  }
}
