import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakayu/views/addkayu_view.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/card_kayu_view.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/custom_bottom_navbar_admin_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/datakayu.controller.dart';

class DatakayuScreen extends GetView<DatakayuController> {
  const DatakayuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableTextView(
          text: "Data Kayu",
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
        } else if (controller.products.isEmpty) {
          return Center(child: Text("Tidak ada data kayu"));
        } else {
          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              return CardKayuView(product: controller.products[index]);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddkayuView());
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
