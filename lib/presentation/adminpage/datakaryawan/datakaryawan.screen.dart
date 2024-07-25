import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakaryawan/views/addkaryawan_view.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/card_karyawan_view.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/custom_bottom_navbar_admin_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/datakaryawan.controller.dart';

class DatakaryawanScreen extends GetView<DatakaryawanController> {
  const DatakaryawanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableTextView(
          text: "Data Karyawan",
          sizetext: 22,
          textcolor: AppColors.blacktext,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.karyawanItems.isEmpty) {
          return Center(child: Text("Tidak ada data kayu"));
        } else {
          return ListView.builder(
            itemCount: controller.karyawanItems.length,
            itemBuilder: (context, index) {
              return CardKaryawanView(
                  karyawan: controller.karyawanItems[index]);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddkaryawanView());
        },
        backgroundColor: AppColors.whiteColor,
        child: Icon(
          Icons.add,
          color: AppColors.coklat7,
        ),
      ),
      bottomNavigationBar: CustomBottomNavbarAdminView(),
    );
  }
}
