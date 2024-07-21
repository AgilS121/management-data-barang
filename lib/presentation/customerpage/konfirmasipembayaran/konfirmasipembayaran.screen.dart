import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_button_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class KonfirmasipembayaranScreen
    extends GetView<ProductcardkeranjangcontrollerController> {
  const KonfirmasipembayaranScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableTextView(
          sizetext: 18,
          text: "Konfirmasi Pembayaran",
          fontWeight: FontWeight.bold,
          textcolor: AppColors.blacktext,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detail Pembayaran",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            _buildPaymentDetailRow(
                "Total Pembayaran", "Rp ${controller.subTotal}"),
            SizedBox(height: 16.h),
            Text(
              "Kemana Uang Harus Dibayarkan",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            _buildPaymentDetailRow("Bank", "Bank BCA"),
            _buildPaymentDetailRow("No. Rekening", "1234567890"),
            _buildPaymentDetailRow("Atas Nama", "UD PUTRA BAROKAH"),
            Spacer(),
            Center(
              child: ReusableButtonView(
                text: "Selesai",
                sizetext: 16.sp,
                widthbutton: 320.w,
                colorbg: AppColors.coklat7,
                colorfe: AppColors.whiteColor,
                textcolor: AppColors.whiteColor,
                onPressed: () {
                  Get.offAllNamed(
                      "/homecustomer"); // Replace with your home route
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16.sp),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
