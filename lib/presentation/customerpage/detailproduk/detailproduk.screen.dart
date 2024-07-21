import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/detailproduk.controller.dart';

class DetailprodukScreen extends GetView<DetailprodukController> {
  const DetailprodukScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailprodukScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailprodukScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
