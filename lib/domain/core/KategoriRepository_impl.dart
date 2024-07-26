import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/repositories/KategoriRepositories.dart';

class CategoryRepositoryImpl implements ICategoryRepository {
  final FirebaseFirestore firestore;

  CategoryRepositoryImpl(this.firestore);

  @override
  Future<void> addCategory(String category) async {
    final docRef = firestore.collection('categories').doc();
    await docRef.set({'name': category});
  }

  @override
  Stream<List<String>> getAllCategories() {
    return firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }
}
