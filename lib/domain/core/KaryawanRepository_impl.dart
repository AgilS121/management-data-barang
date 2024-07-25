import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dekaybaro/domain/models/KaryawanModel.dart';
import 'package:dekaybaro/domain/repositories/KaryawanRepositories.dart';
import 'package:firebase_storage/firebase_storage.dart';

class KaryawanrepositoryImpl implements KaryawanRepositories {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  KaryawanrepositoryImpl(this.firestore, this.storage);

  @override
  Future<Either<Exception, KaryawanModel>> addKaryawan(
      KaryawanModel karyawan) async {
    try {
      DocumentReference docRef =
          await firestore.collection('karyawans').add(karyawan.toJson());

      // Tambahkan ID dokumen ke produk
      KaryawanModel savedKaryawan = karyawan.copyWith(id: docRef.id);

      // Update dokumen dengan ID yang baru
      await docRef.update({'id': docRef.id});

      return Right(savedKaryawan);
    } catch (e) {
      return Left(Exception('Gagal menambahkan produk: $e'));
    }
  }

  @override
  Future<Either<Exception, List<KaryawanModel>>> getAllKaryawan() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('karyawans').get();
      List<KaryawanModel> karyawans = snapshot.docs.map((doc) {
        return KaryawanModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return Right(karyawans);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, KaryawanModel>> updateKaryawan(
      KaryawanModel karyawan) async {
    try {
      await FirebaseFirestore.instance
          .collection('karyawans')
          .doc(karyawan.id)
          .update(karyawan.toJson());
      return Right(karyawan);
    } catch (e) {
      return Left(Exception('Error updating karyawan: $e'));
    }
  }

  @override
  Future<Either<Exception, void>> deleteKaryawan(String id) async {
    try {
      // Menghapus dokumen produk dari Firestore
      await firestore.collection('karyawans').doc(id).delete();

      // Mengembalikan Right dengan null, menandakan operasi berhasil
      return Right(null);
    } catch (e) {
      // Mengembalikan Left dengan pesan kesalahan jika ada kesalahan
      return Left(Exception('Error deleting karyawan: $e'));
    }
  }
}
