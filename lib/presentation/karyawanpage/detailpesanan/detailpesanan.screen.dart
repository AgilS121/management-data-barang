import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detailpesanan.controller.dart';

class DetailpesananScreen extends GetView<DetailpesananController> {
  const DetailpesananScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailpesananScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailpesananScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
