import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/pengaturancustomer.controller.dart';

class PengaturancustomerScreen extends GetView<PengaturancustomerController> {
  const PengaturancustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(() => ListTile(
                leading: Icon(controller.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode),
                title: Text('Tema'),
                subtitle:
                    Text(controller.isDarkMode.value ? 'Gelap' : 'Terang'),
                onTap: () {
                  controller.toggleTheme();
                },
              )),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Versi Aplikasi'),
            subtitle: Text('1.0.0'), // Gantilah dengan versi aplikasi Anda
          ),
        ],
      ),
    );
  }
}
