import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/datakayu.controller.dart';

class DatakayuScreen extends GetView<DatakayuController> {
  const DatakayuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DatakayuScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DatakayuScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
