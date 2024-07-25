import 'package:dekaybaro/domain/models/KaryawanModel.dart';
import 'package:dekaybaro/infrastructure/theme/colors.dart';
import 'package:dekaybaro/presentation/adminpage/datakaryawan/controllers/datakaryawan.controller.dart';
import 'package:dekaybaro/presentation/utils/views/reusable_text_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailkaryawanView extends GetView<DatakaryawanController> {
  const DetailkaryawanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final KaryawanModel karyawan = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: ReusableTextView(
          text: "Detail Karyawan",
          sizetext: 20,
          textcolor: AppColors.blacktext,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: NetworkImage(karyawan.image!),
              radius: 50,
            ),
            SizedBox(height: 20),
            ReusableTextView(
              text: karyawan.name!,
              sizetext: 32,
              textcolor: AppColors.greeen1,
              fontWeight: FontWeight.bold,
            ),
            ReusableTextView(
                text: karyawan.position!,
                sizetext: 18,
                textcolor: AppColors.greytext),
            Divider(),
            ListTile(
              leading: Icon(Icons.email),
              title: ReusableTextView(
                  text: karyawan.email!,
                  sizetext: 16,
                  textcolor: AppColors.greytext),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: ReusableTextView(
                  text: karyawan.phone!,
                  sizetext: 16,
                  textcolor: AppColors.greytext),
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: ReusableTextView(
                  text: karyawan.status!,
                  sizetext: 16,
                  textcolor: AppColors.greytext),
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: ReusableTextView(
                  text: 'Rp ${karyawan.salary}',
                  sizetext: 16,
                  textcolor: AppColors.greytext),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tampilkan dialog konfirmasi sebelum menghapus produk
          Get.dialog(
            AlertDialog(
              title: Text("Hapus Karyawan"),
              content:
                  Text("Apakah Anda yakin ingin menghapus data Karyawan ini?"),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Batal"),
                ),
                TextButton(
                  onPressed: () async {
                    await controller.deleteKaryawanById(karyawan.id!);
                    Get.back();
                    Get.back();
                  },
                  child: Text("Hapus"),
                ),
              ],
            ),
          );
        },
        backgroundColor: AppColors.whiteColor,
        child: Icon(
          Icons.delete,
          color: AppColors.coklat7,
        ),
      ),
    );
  }
}
