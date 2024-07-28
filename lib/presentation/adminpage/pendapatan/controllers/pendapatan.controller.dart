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
    revenueData.value = await getRevenueData(selectedFilter.value);
    updateChartData();
  }

  void updateChartData() {
    chartData.value = revenueData
        .map((item) => ChartData(date: item.date, value: item.amount))
        .toList();
  }

  Future<void> downloadCsvReport() async {
    String filePath = await generateCsvReport(revenueData);
    OpenFile.open(filePath);
  }

  Future<void> downloadPdfReport() async {
    String filePath = await generatePdfReport(revenueData);
    OpenFile.open(filePath);
  }
}
