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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Bulan / JT', style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: controller.selectedFilter.value,
                  items: [
                    DropdownMenuItem(
                        value: 'weekly', child: Text('Per Minggu')),
                    DropdownMenuItem(
                        value: 'monthly', child: Text('Per Bulan')),
                    DropdownMenuItem(value: 'yearly', child: Text('Per Tahun')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.setFilter(value);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Obx(() {
              return SizedBox(
                height: 300, // Tentukan tinggi yang tetap
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
                                  style: TextStyle(
                                      fontSize:
                                          10), // Kurangi ukuran font jika perlu
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
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                  ),
                ),
              );
            }),
            SizedBox(height: 32),
            Text('Pemasukan Harian', style: TextStyle(fontSize: 18)),
            Card(
              child: ListTile(
                title: Text('Kayu Alba'),
                subtitle: Text('14 July 2021'),
                trailing: Text(
                  '+700.000',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: IconButton(
                icon: Icon(Icons.download),
                onPressed: () {
                  // Handle download action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
