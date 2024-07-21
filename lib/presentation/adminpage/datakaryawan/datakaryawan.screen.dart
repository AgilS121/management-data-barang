import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/datakaryawan.controller.dart';

class DatakaryawanScreen extends GetView<DatakaryawanController> {
  const DatakaryawanScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DatakaryawanScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DatakaryawanScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
