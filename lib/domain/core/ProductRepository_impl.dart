import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/repositories/ProductRepositories.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  ProductRepositoryImpl(this.firestore, this.storage);

  // @override
  // Future<Either<Exception, Product>> addProduct(Product product) async {
  //   try {
  //     // Upload images to Firebase Storage and get URLs
  //     List<String> imageUrls = [];
  //     for (String path in product.image) {
  //       File file = File(path);
  //       String fileName = file.path.split('/').last;
  //       Reference ref = storage.ref().child('products/$fileName');
  //       UploadTask uploadTask = ref.putFile(file);
  //       TaskSnapshot taskSnapshot = await uploadTask;
  //       String downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //       imageUrls.add(downloadUrl);
  //     }

  //     // Create a new product with the image URLs
  //     Product newProduct = Product(
  //       id: product.id,
  //       name: product.name,
  //       price: product.price,
  //       image: imageUrls,
  //       deskripsi: product.deskripsi,
  //       adalahKayuGelondongan: product.adalahKayuGelondongan,
  //       dimensi: product.dimensi,
  //       konfigurasi: product.konfigurasi,
  //       jenisKayu: product.jenisKayu,
  //       kualitas: product.kualitas,
  //       sertifikasiKeberlanjutan: product.sertifikasiKeberlanjutan,
  //       stok: product.stok,
  //     );

  //     // Save product to Firestore
  //     await firestore.collection('products').add(newProduct.toJson());
  //     return Right(newProduct);
  //   } catch (e) {
  //     return Left(Exception(e.toString()));
  //   }
  // }

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
      await firestore.collection('products').doc(id.toString()).delete();
      return Right(null);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
