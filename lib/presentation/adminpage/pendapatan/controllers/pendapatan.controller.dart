import 'package:dekaybaro/domain/models/ChartData.dart';
import 'package:get/get.dart';

class PendapatanController extends GetxController {
  var selectedFilter = 'daily'.obs;
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
    // Simulasi data fetch berdasarkan filter
    switch (selectedFilter.value) {
      case 'daily':
        chartData.value = [
          ChartData(date: '1 Jul', value: 50),
          ChartData(date: '2 Jul', value: 55),
          ChartData(date: '3 Jul', value: 60),
          ChartData(date: '4 Jul', value: 52),
          ChartData(date: '5 Jul', value: 58),
          ChartData(date: '6 Jul', value: 65),
          ChartData(date: '7 Jul', value: 62),
        ];
        break;
      case 'monthly':
        chartData.value = [
          ChartData(date: 'Jan', value: 300),
          ChartData(date: 'Feb', value: 280),
          ChartData(date: 'Mar', value: 310),
          ChartData(date: 'Apr', value: 290),
          ChartData(date: 'May', value: 320),
          ChartData(date: 'Jun', value: 350),
        ];
        break;
      case 'yearly':
        chartData.value = [
          ChartData(date: '2019', value: 3500),
          ChartData(date: '2020', value: 3200),
          ChartData(date: '2021', value: 3800),
          ChartData(date: '2022', value: 4000),
          ChartData(date: '2023', value: 4200),
        ];
        break;
    }
  }
}
