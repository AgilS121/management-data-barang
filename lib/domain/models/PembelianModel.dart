import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';

class Purchase {
  final String? id;
  final String userId;
  final List<Product> products;
  final String address;
  final String paymentMethod;
  final double subTotal;
  final double ongkir;
  final double total;
  final String date;

  Purchase({
    this.id,
    required this.userId,
    required this.products,
    required this.address,
    required this.paymentMethod,
    required this.subTotal,
    required this.ongkir,
    required this.total,
    required this.date,
  });

  factory Purchase.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Purchase(
      id: snapshot.id,
      userId: data['userId'],
      products: (data['products'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
      address: data['address'],
      paymentMethod: data['paymentMethod'],
      subTotal: (data['subTotal'] as num).toDouble(),
      ongkir: (data['ongkir'] as num).toDouble(),
      total: (data['total'] as num).toDouble(),
      date: data['date'],
    );
  }

  // Convert the Purchase object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products.map((product) => product.toJson()).toList(),
      'address': address,
      'paymentMethod': paymentMethod,
      'subTotal': subTotal,
      'ongkir': ongkir,
      'total': total,
      'date': date,
    };
  }
}
