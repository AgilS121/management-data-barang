import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw; // For PDF generation
import 'package:dekaybaro/domain/models/PendapatanModel.dart';
import 'package:dekaybaro/domain/repositories/PendapatanRepository.dart';

class RevenueRepositoryImpl implements RevenueRepository {
  final FirebaseFirestore _firestore;

  RevenueRepositoryImpl(this._firestore);

  @override
  Future<List<RevenueData>> getRevenueData(String filter) async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('purchases').get();

      print("Data snapshot: ${snapshot.docs.length} documents found.");
      List<RevenueData> revenueList = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        print("Document ID: ${doc.id}, Data: $data");

        // Ambil nama produk dari array produk
        List<dynamic> products = data['products'] ?? [];
        List<String> productNames = products.map((product) {
          return product['name'] as String? ?? '';
        }).toList();

        // Gabungkan nama produk menjadi satu string jika diperlukan
        String productNamesString = productNames.join(', ');

        // Parse data ke model RevenueData
        return RevenueData(
          date: data['date'],
          amount: data['total'],
          productName: productNamesString,
        );
      }).toList();

      print("Parsed revenue data: ${revenueList.length} records.");

      // Periksa apakah revenueList tidak kosong dan berisi data
      if (revenueList.isEmpty) {
        print("No data found in the 'purchases' collection.");
      }

      // Format tanggal untuk parsing string tanggal (sesuaikan format jika perlu)
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime now = DateTime.now();

      switch (filter) {
        case 'daily':
          revenueList = revenueList.where((item) {
            DateTime itemDate = DateTime.parse(item.date);
            return itemDate.isAfter(now.subtract(Duration(days: 1)));
          }).toList();
          print(
              "Filtered data for daily: ${revenueList.length} records found.");
          break;
        case 'monthly':
          revenueList = revenueList.where((item) {
            DateTime itemDate = DateTime.parse(item.date);
            return itemDate.isAfter(now.subtract(Duration(days: 30)));
          }).toList();
          print(
              "Filtered data for monthly: ${revenueList.length} records found.");
          break;
        case 'yearly':
          revenueList = revenueList.where((item) {
            DateTime itemDate = DateTime.parse(item.date);
            return itemDate.isAfter(now.subtract(Duration(days: 365)));
          }).toList();
          print(
              "Filtered data for yearly: ${revenueList.length} records found.");
          break;
        default:
          print("Invalid filter specified: $filter");
      }

      return revenueList;
    } catch (e) {
      print("Error fetching revenue data 1: $e");
      return [];
    }
  }

  @override
  Future<String> generateCsvReport(List<RevenueData> data) async {
    // Buat konten CSV
    List<List<dynamic>> rows = [
      ['Date', 'Product Name', 'Amount'] // Tambahkan header
    ];

    // Tambahkan baris data
    for (var item in data) {
      rows.add([item.date, item.productName, item.amount]);
    }

    // Konversi baris menjadi format CSV
    String csv = const ListToCsvConverter().convert(rows);

    // Simpan file di direktori sementara
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String fileName =
        'revenue_report_${DateTime.now().millisecondsSinceEpoch}.csv';
    File csvFile = File('$tempPath/$fileName');
    await csvFile.writeAsString(csv);
    print('CSV file saved at: ${csvFile.path}');

    // Kembalikan path file
    return csvFile.path;
  }

  @override
  Future<String> generatePdfReport(List<RevenueData> data) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/fonts/Sansation_Regular.ttf");
    final ttf = pw.Font.ttf(font);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Revenue Report', style: pw.TextStyle(font: ttf)),
          ); // Center
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(
        "${output.path}/revenue_report_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(await pdf.save());
    print('PDF file saved at: ${file.path}');
    return file.path;
  }
}
