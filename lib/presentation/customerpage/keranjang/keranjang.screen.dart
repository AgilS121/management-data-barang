import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/controllers/productcardkeranjangcontroller_controller.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/custom_bottom_nav_bar_view.dart';
import 'package:dekaybaro/presentation/utils/componentcustomers/views/productcardkeranjang_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_button_view.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class KeranjangScreen
    extends GetView<ProductcardkeranjangcontrollerController> {
  const KeranjangScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductcardkeranjangcontrollerController controller =
        Get.put(ProductcardkeranjangcontrollerController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableTextView(
          text: "Keranjang",
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
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: controller.cartItems[index]);
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReusableButtonView(
                  text: "Lanjutkan Pembayaran",
                  sizetext: 16,
                  colorbg: AppColors.coklat7,
                  colorfe: AppColors.whiteColor,
                  textcolor: AppColors.whiteColor,
                  onPressed: () {
                    Get.toNamed("/pembayaran");
                  },
                  widthbutton: 320.w),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
