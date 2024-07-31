import 'package:dekaybaro/domain/models/ChartData.dart';
import 'package:dekaybaro/domain/models/PendapatanModel.dart';
import 'package:dekaybaro/domain/usecase/PendapatanUseCase.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class PendapatanController extends GetxController {
  final GetRevenueData getRevenueData;
  final GenerateCsvReport generateCsvReport;
  final GeneratePdfReport generatePdfReport;

  PendapatanController({
    required this.getRevenueData,
    required this.generateCsvReport,
    required this.generatePdfReport,
  });

  var selectedFilter = 'daily'.obs;
  var chartData = <ChartData>[].obs;
  var revenueData = <RevenueData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    fetchData();
  }

  Future<void> fetchData() async {
    print("Fetching data with filter: ${selectedFilter.value}");
    try {
      revenueData.value = await getRevenueData(selectedFilter.value);
      print("Data fetched: ${revenueData.length} records found.");
      updateChartData();
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void updateChartData() {
    chartData.value = revenueData
        .map((item) => ChartData(date: item.date, value: item.amount))
        .toList();
    print("Chart data updated: ${chartData.length} records.");
  }

  Future<void> downloadCsvReport() async {
    try {
      String filePath = await generateCsvReport(revenueData);
      print("CSV report generated at: $filePath");
      OpenFile.open(filePath);
    } catch (e) {
      print("Error generating CSV report: $e");
    }
  }

  Future<void> downloadPdfReport() async {
    try {
      String filePath = await generatePdfReport(revenueData);
      print("PDF report generated at: $filePath");
      OpenFile.open(filePath);
    } catch (e) {
      print("Error generating PDF report: $e");
    }
  }
}
