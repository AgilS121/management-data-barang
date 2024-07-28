class RevenueData {
  final String date;
  final String productName;
  final double amount;

  RevenueData(
      {required this.date, required this.productName, required this.amount});

  factory RevenueData.fromFirestore(Map<String, dynamic> data) {
    return RevenueData(
      date: data['date'],
      productName: data['productName'],
      amount: data['amount'].toDouble(),
    );
  }
}
