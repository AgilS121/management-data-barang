import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/stokkayu.controller.dart';

class StokkayuScreen extends GetView<StokkayuController> {
  const StokkayuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StokkayuScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StokkayuScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
