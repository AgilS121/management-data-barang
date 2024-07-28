import 'package:dekaybaro/domain/models/PendapatanModel.dart';

abstract class RevenueRepository {
  Future<List<RevenueData>> getRevenueData(String filter);
  Future<String> generateCsvReport(List<RevenueData> data);
  Future<String> generatePdfReport(List<RevenueData> data);
}
