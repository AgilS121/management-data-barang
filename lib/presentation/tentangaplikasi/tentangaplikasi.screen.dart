import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/tentangaplikasi.controller.dart';

class TentangaplikasiScreen extends GetView<TentangaplikasiController> {
  const TentangaplikasiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang Aplikasi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Aplikasi ini dibuat untuk memberikan layanan terbaik kepada pengguna kami. Dengan aplikasi ini, Anda dapat melakukan berbagai macam kegiatan dengan mudah dan cepat.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Versi Aplikasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '1.0.0', // Gantilah dengan versi aplikasi Anda
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Kontak',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Email: support@example.com', // Gantilah dengan email kontak Anda
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Telepon: +62 123 4567 890', // Gantilah dengan nomor telepon kontak Anda
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
