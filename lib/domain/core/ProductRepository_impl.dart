import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/repositories/ProductRepositories.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ProductRepositoryImpl(this.firestore, this.storage);

  @override
  Future<Either<Exception, Product>> addProduct(Product product) async {
    try {
      DocumentReference docRef =
          await firestore.collection('products').add(product.toJson());

      // Tambahkan ID dokumen ke produk
      Product savedProduct = product.copyWith(id: docRef.id);

      // Update dokumen dengan ID yang baru
      await docRef.update({'id': docRef.id});

      return Right(savedProduct);
    } catch (e) {
      return Left(Exception('Gagal menambahkan produk: $e'));
    }
  }

  @override
  Future<Either<Exception, List<Product>>> getAllProducts() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('products').get();
      List<Product> products = snapshot.docs.map((doc) {
        return Product.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return Right(products);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Product>> updateProduct(Product product) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(product.id)
          .update(product.toJson());
      return Right(product);
    } catch (e) {
      return Left(Exception('Error updating product: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> deleteProduct(String id) async {
    try {
      // Menghapus dokumen produk dari Firestore
      await firestore.collection('products').doc(id).delete();

      // Mengembalikan Right dengan null, menandakan operasi berhasil
      return Right(null);
    } catch (e) {
      // Mengembalikan Left dengan pesan kesalahan jika ada kesalahan
      return Left(Exception('Error deleting product: $e'));
    }
  }
}
