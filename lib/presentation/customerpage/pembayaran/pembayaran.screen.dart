import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/addresinputfield_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/paymentmethodselector_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/productcardkeranjang_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/totalcard_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_button_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class PembayaranScreen
    extends GetView<ProductcardkeranjangcontrollerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() => ReusableTextView(
              sizetext: 18,
              text: controller.paymentStep.value == 0
                  ? "Pembayaran"
                  : "Metode Pembayaran",
              fontWeight: FontWeight.bold,
              textcolor: AppColors.blacktext,
            )),
        centerTitle: true,
      ),
      body: Obx(() =>
          controller.paymentStep.value == 0 ? _buildStep1() : _buildStep2()),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildStep1() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: controller.cartItems.length,
            itemBuilder: (context, index) =>
                ProductCard(product: controller.cartItems[index]),
          ),
        ),
        TotalcardView(
            subTotal: controller.subTotal, ongkir: controller.ongkir.value),
      ],
    );
  }

  Widget _buildStep2() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddressSection(),
            SizedBox(height: 16.h),
            PaymentmethodselectorView(),
            SizedBox(height: 16.h),
            TotalcardView(
                subTotal: controller.subTotal, ongkir: controller.ongkir.value),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alamat Pembelian',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.h),
        Obx(() {
          return controller.localAddress.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.localAddress.value,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => Get.toNamed("/edit-address"),
                    ),
                  ],
                )
              : Center(
                  child: ReusableButtonView(
                    text: "Tambah Alamat",
                    sizetext: 16.sp,
                    widthbutton: 200.w,
                    colorbg: AppColors.coklat7,
                    colorfe: AppColors.whiteColor,
                    textcolor: AppColors.whiteColor,
                    onPressed: () => Get.toNamed("/addalamat"),
                  ),
                );
        }),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => ReusableButtonView(
            sizetext: 16,
            colorbg: AppColors.coklat7,
            colorfe: AppColors.whiteColor,
            textcolor: AppColors.whiteColor,
            widthbutton: 320.w,
            text: controller.paymentStep.value == 0
                ? "Lanjutkan Pembayaran"
                : "Bayar",
            onPressed: controller.paymentStep.value == 0
                ? controller.nextStep
                : () => Get.toNamed("/konfirmasipembayaran"),
          )),
    );
  }
}
