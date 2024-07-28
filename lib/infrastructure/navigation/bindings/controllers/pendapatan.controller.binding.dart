import 'package:dekaybaro/domain/core/PendapatanRepository_impl.dart';
import 'package:get/get.dart';
import 'package:dekaybaro/domain/usecase/PendapatanUseCase.dart';
import 'package:dekaybaro/presentation/adminpage/pendapatan/controllers/pendapatan.controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PendapatanControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendapatanController>(() {
      final repository = RevenueRepositoryImpl(FirebaseFirestore.instance);
      return PendapatanController(
        getRevenueData: GetRevenueData(repository),
        generateCsvReport: GenerateCsvReport(repository),
        generatePdfReport: GeneratePdfReport(repository),
      );
    });
  }
}
