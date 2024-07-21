import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TotalProductView extends GetView {
  final int subTotal;
  final int ongkir;

  const TotalProductView({
    Key? key,
    required this.subTotal,
    required this.ongkir,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = subTotal + ongkir;
    final formatter = NumberFormat("#,###", "id_ID");

    return Card(
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.transparent, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRow("Sub Total", subTotal, formatter),
            _buildRow("Ongkir", ongkir, formatter),
            Divider(thickness: 1, height: 24),
            _buildRow("Total", total, formatter, isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, int value, NumberFormat formatter,
      {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            "${formatter.format(value)}",
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
