import 'package:dekaybaro/domain/models/ChartData.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/pendapatan.controller.dart';

class PendapatanScreen extends GetView<PendapatanController> {
  const PendapatanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Rekapitulasi'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Dropdown
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filter:', style: TextStyle(fontSize: 16)),
                  DropdownButton<String>(
                    value: controller.selectedFilter.value,
                    items: [
                      DropdownMenuItem(value: 'daily', child: Text('Harian')),
                      DropdownMenuItem(
                          value: 'monthly', child: Text('Bulanan')),
                      DropdownMenuItem(value: 'yearly', child: Text('Tahunan')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setFilter(value);
                      }
                    },
                  ),
                ],
              );
            }),
            SizedBox(height: 16),

            // Bar Chart
            Obx(() {
              return SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    barGroups:
                        controller.chartData.asMap().entries.map((entry) {
                      int index = entry.key;
                      ChartData data = entry.value;
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: data.value,
                            color: Colors.brown,
                            width: 16,
                          ),
                        ],
                      );
                    }).toList(),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 &&
                                index < controller.chartData.length) {
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  controller.chartData[index].date,
                                  style: TextStyle(fontSize: 10),
                                ),
                              );
                            }
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: Text(''),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                  ),
                ),
              );
            }),
            SizedBox(height: 32),

            // Daily Income List (Example)
            Text('Pemasukan Harian', style: TextStyle(fontSize: 18)),
            Obx(() {
              return Column(
                children: controller.revenueData.map((data) {
                  return Card(
                    child: ListTile(
                      title: Text(data.productName),
                      subtitle: Text(data.date),
                      trailing: Text(
                        '+${data.amount}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            Spacer(),

            // Download Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Download CSV'),
                  onPressed: () => controller.downloadCsvReport(),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  child: Text('Download PDF'),
                  onPressed: () => controller.downloadPdfReport(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
