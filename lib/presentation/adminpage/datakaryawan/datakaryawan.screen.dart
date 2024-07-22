import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/card_karyawan_view.dart';
import 'package:dekaybaro/presentation/utils/componentadmins/views/custom_bottom_navbar_admin_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_button_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.karyawanitems.length,
                    itemBuilder: (context, index) {
                      return CardKaryawanView(
                          karyawan: controller.karyawanitems[index]);
                    },
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logika ketika tombol ditekan
        },
        backgroundColor: AppColors.coklat7,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: CustomBottomNavbarAdminView(),
    );
  }
}
