import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddresinputfieldView extends GetView {
  final Function(String) onAddressChanged;

  const AddresinputfieldView({Key? key, required this.onAddressChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Alamat Pengiriman',
          border: OutlineInputBorder(),
        ),
        maxLines: 3,
        onChanged: onAddressChanged,
      ),
    );
  }
}
