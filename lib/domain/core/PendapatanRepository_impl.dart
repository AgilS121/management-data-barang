import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw; // For PDF generation
import 'package:dekaybaro/domain/models/PendapatanModel.dart';
import 'package:dekaybaro/domain/repositories/PendapatanRepository.dart';

class RevenueRepositoryImpl implements RevenueRepository {
  final FirebaseFirestore _firestore;

  RevenueRepositoryImpl(this._firestore);

  @override
  Future<List<RevenueData>> getRevenueData(String filter) async {
    QuerySnapshot snapshot = await _firestore.collection('purchases').get();
    List<RevenueData> revenueList = snapshot.docs.map((doc) {
      return RevenueData.fromFirestore(doc.data() as Map<String, dynamic>);
    }).toList();

    // Implement filtering logic based on the filter parameter
    switch (filter) {
      case 'daily':
        // Filter for daily data
        break;
      case 'monthly':
        // Filter for monthly data
        break;
      case 'yearly':
        // Filter for yearly data
        break;
    }

    return revenueList;
  }

  // @override
  // Future<String> generateCsvReport(List<RevenueData> data) async {
  //   try {
  //     // Buat konten CSV
  //     List<List<dynamic>> rows = [
  //       ['Date', 'Product Name', 'Amount']
  //     ];

  //     // Tambahkan baris data
  //     for (var item in data) {
  //       rows.add([item.date, item.productName, item.amount]);
  //     }

  //     // Konversi baris ke format CSV
  //     String csv = const ListToCsvConverter().convert(rows);

  //     // Coba mendapatkan direktori penyimpanan
  //     Directory appDocDir = await getApplicationDocumentsDirectory();
  //     String appDocPath = appDocDir.path;
  //     String fileName =
  //         'revenue_report_${DateTime.now().millisecondsSinceEpoch}.csv';

  //     // Coba menulis file
  //     File csvFile = File('$appDocPath/$fileName');
  //     await csvFile.writeAsString(csv);

  //     print('File saved at: ${csvFile.path}');
  //     return csvFile.path;
  //   } catch (e) {
  //     print('Error generating CSV report: $e');
  //     return '';
  //   }
  // }

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
    print('File saved at: ${csvFile.path}');

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
            child: pw.Text('Hello World', style: pw.TextStyle(font: ttf)),
          ); // Center
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
    print('File saved at: ${file.path}');
    return file.path;
  }
}
