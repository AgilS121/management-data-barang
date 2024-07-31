import 'package:dekaybaro/domain/models/PembelianModel.dart';

abstract class PurchaseRepository {
  Stream<List<Purchase>> getPurchases();
  Future<void> addPurchase(Purchase purchase);
  Future<void> updatePurchase(Purchase purchase);
  Future<void> deletePurchase(String id);
  Future<Purchase?> getPurchaseById(String id);
}
