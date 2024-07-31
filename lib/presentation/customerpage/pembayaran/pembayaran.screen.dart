import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/customerpage/pembayaran/controllers/pembayaran.controller.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/paymentmethodselector_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/productcardkeranjang_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/totalcard_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_button_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PembayaranScreen extends GetView<PembayaranController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          subTotal: controller.subTotal.toInt(),
          ongkir: controller.ongkir.value.toInt(),
        ),
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
              subTotal: controller.subTotal.toInt(),
              ongkir: controller.ongkir.value.toInt(),
            ),
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
          if (controller.addresses.isEmpty) {
            return Center(
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
          } else {
            return Column(
              children: [
                ...controller.addresses.map((address) {
                  return ListTile(
                    title: Text(address.street),
                    subtitle: Text("${address.city}, ${address.postalCode}"),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () =>
                          Get.toNamed("/edit-address", arguments: address),
                    ),
                    onTap: () => controller.selectAddress(address),
                  );
                }).toList(),
                Center(
                  child: ReusableButtonView(
                    text: "Tambah Alamat Baru",
                    sizetext: 16.sp,
                    widthbutton: 200.w,
                    colorbg: AppColors.coklat7,
                    colorfe: AppColors.whiteColor,
                    textcolor: AppColors.whiteColor,
                    onPressed: () => Get.toNamed("/addalamat"),
                  ),
                ),
              ],
            );
          }
        }),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        final isPaymentStep = controller.paymentStep.value == 1;
        return ReusableButtonView(
          sizetext: 16,
          colorbg: AppColors.coklat7,
          colorfe: AppColors.whiteColor,
          textcolor: AppColors.whiteColor,
          widthbutton: 320.w,
          text: isPaymentStep ? "Bayar" : "Lanjutkan Pembayaran",
          onPressed: () async {
            if (isPaymentStep) {
              // Handle the payment process
              await controller.makePayment();
            } else {
              // Move to payment method selection step
              controller.nextStep();
            }
          },
        );
      }),
    );
  }
}
