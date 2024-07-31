import 'package:dekaybaro/presentation/customerpage/pembayaran/controllers/pembayaran.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentmethodselectorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the instance of PembayaranController
    final PembayaranController controller = Get.find<PembayaranController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metode Pembayaran',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Obx(() {
            return Column(
              children: [
                RadioListTile<String>(
                  title: Text('Transfer Bank'),
                  value: 'Transfer Bank',
                  groupValue: controller.paymentMethod.value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.setPaymentMethod(value);
                    }
                  },
                ),
                RadioListTile<String>(
                  title: Text('Kartu Kredit'),
                  value: 'Kartu Kredit',
                  groupValue: controller.paymentMethod.value,
                  onChanged: (value) {
                    if (value != null) {
                      controller.setPaymentMethod(value);
                    }
                  },
                ),
                // Add more payment methods here
              ],
            );
          }),
        ],
      ),
    );
  }
}
