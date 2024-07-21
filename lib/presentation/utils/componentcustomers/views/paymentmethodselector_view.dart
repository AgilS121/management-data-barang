import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentmethodselectorView extends StatefulWidget {
  const PaymentmethodselectorView({Key? key}) : super(key: key);

  @override
  _PaymentmethodselectorViewState createState() =>
      _PaymentmethodselectorViewState();
}

class _PaymentmethodselectorViewState extends State<PaymentmethodselectorView> {
  String _selectedMethod = 'Transfer Bank';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Metode Pembayaran',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          RadioListTile(
            title: Text('Transfer Bank'),
            value: 'Transfer Bank',
            groupValue: _selectedMethod,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value.toString();
              });
            },
          ),
          RadioListTile(
            title: Text('Kartu Kredit'),
            value: 'Kartu Kredit',
            groupValue: _selectedMethod,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value.toString();
              });
            },
          ),
          // Tambahkan metode pembayaran lainnya di sini
        ],
      ),
    );
  }
}
