import 'package:dekaybaro/domain/models/KaryawanModel.dart';
import 'package:get/get.dart';

class DatakaryawanController extends GetxController {
  final RxList<KaryawanModel> karyawanitems = <KaryawanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Contoh data
    karyawanitems.addAll([
      KaryawanModel(
        id: 1,
        name: 'Jack',
        email: 'jack@gmail.com',
        phone: '089665881651',
        position: 'Karyawan Tetap',
        status: 'Aktif',
        salary: '500000',
        image:
            'https://static-00.iconduck.com/assets.00/9-404-error-illustration-2048x908-vp03fkyu.png',
      ),
    ]);
  }
}
