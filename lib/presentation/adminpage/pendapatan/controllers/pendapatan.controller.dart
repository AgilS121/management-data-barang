import 'package:get/get.dart';

class PendapatanController extends GetxController {
  var selectedFilter = 'monthly'.obs;
  var chartData = <ChartData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    fetchData();
  }

  void fetchData() {
    // Fetch and update chartData based on selectedFilter
    // This is just a placeholder, replace with your data fetching logic
    chartData.value = [
      ChartData(date: '10 Jan', value: 70),
      ChartData(date: '10 Feb', value: 68),
      ChartData(date: '9 Mar', value: 66),
      ChartData(date: '11 Apr', value: 64),
      ChartData(date: '10 Mei', value: 64),
      ChartData(date: '11 Jun', value: 64),
    ];
  }
}

class ChartData {
  final String date;
  final double value;

  ChartData({required this.date, required this.value});
}
