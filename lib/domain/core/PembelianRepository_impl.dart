import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/models/PembelianModel.dart';
import 'package:dekaybaro/domain/repositories/BayarRepositories.dart';

class PurchaseRepositoryImpl implements PurchaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'purchases';

  @override
  Stream<List<Purchase>> getPurchases() {
    return _firestore.collection('purchases').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Purchase.fromSnapshot(doc)).toList());
  }

  @override
  Future<void> addPurchase(Purchase purchase) async {
    try {
      await _firestore.collection(_collection).add(purchase.toJson());
    } catch (e) {
      throw Exception('Failed to add purchase: $e');
    }
  }

  @override
  Future<void> updatePurchase(Purchase purchase) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(purchase.id)
          .update(purchase.toJson());
    } catch (e) {
      throw Exception('Failed to update purchase: $e');
    }
  }

  @override
  Future<void> deletePurchase(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete purchase: $e');
    }
  }

  @override
  Future<Purchase?> getPurchaseById(String id) async {
    final doc = await _firestore.collection('purchases').doc(id).get();
    if (doc.exists) {
      return Purchase.fromSnapshot(doc);
    }
    return null;
  }
}
