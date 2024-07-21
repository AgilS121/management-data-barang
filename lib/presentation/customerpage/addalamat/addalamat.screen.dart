import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_button_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/addalamat.controller.dart';

class AddalamatScreen extends GetView<AddalamatController> {
  const AddalamatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Alamat"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dikirim Untuk Anon",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: controller.phoneController,
                decoration: InputDecoration(
                  labelText: "Telepon",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: controller.addressController,
                decoration: InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              Center(
                child: ReusableButtonView(
                  text: "Tambah Alamat",
                  sizetext: 16.sp,
                  widthbutton: 320.w,
                  colorbg: AppColors.coklat7,
                  colorfe: AppColors.whiteColor,
                  textcolor: AppColors.whiteColor,
                  onPressed: () {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      controller.addAddress();
                      Get.back();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
