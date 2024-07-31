import 'package:dekaybaro/domain/models/PembelianModel.dart';
import 'package:dekaybaro/domain/repositories/BayarRepositories.dart';

class GetPurchases {
  final PurchaseRepository repository;

  GetPurchases(this.repository);

  Stream<List<Purchase>> call() => repository.getPurchases();
}

class AddPurchase {
  final PurchaseRepository repository;

  AddPurchase(this.repository);

  Future<void> call(Purchase purchase) => repository.addPurchase(purchase);
}

class UpdatePurchase {
  final PurchaseRepository repository;

  UpdatePurchase(this.repository);

  Future<void> call(Purchase purchase) => repository.updatePurchase(purchase);
}

class DeletePurchase {
  final PurchaseRepository repository;

  DeletePurchase(this.repository);

  Future<void> call(String id) => repository.deletePurchase(id);
}

class GetPurchaseById {
  final PurchaseRepository repository;

  GetPurchaseById(this.repository);

  Future<Purchase?> call(String id) => repository.getPurchaseById(id);
}
