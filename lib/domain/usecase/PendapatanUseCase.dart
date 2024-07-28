import 'package:dekaybaro/domain/models/PendapatanModel.dart';
import 'package:dekaybaro/domain/repositories/PendapatanRepository.dart';

class GetRevenueData {
  final RevenueRepository repository;

  GetRevenueData(this.repository);

  Future<List<RevenueData>> call(String filter) async {
    return await repository.getRevenueData(filter);
  }
}

class GenerateCsvReport {
  final RevenueRepository repository;

  GenerateCsvReport(this.repository);

  Future<String> call(List<RevenueData> data) async {
    return await repository.generateCsvReport(data);
  }
}

class GeneratePdfReport {
  final RevenueRepository repository;

  GeneratePdfReport(this.repository);

  Future<String> call(List<RevenueData> data) async {
    return await repository.generatePdfReport(data);
  }
}
