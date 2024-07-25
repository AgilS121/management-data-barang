import 'package:dartz/dartz.dart';
import 'package:dekaybaro/domain/models/KaryawanModel.dart';

abstract class KaryawanRepositories {
  Future<Either<Exception, KaryawanModel>> addKaryawan(KaryawanModel karyawan);
  Future<Either<Exception, List<KaryawanModel>>> getAllKaryawan();
  Future<Either<Exception, KaryawanModel>> updateKaryawan(
      KaryawanModel karyawan);
  Future<Either<Exception, void>> deleteKaryawan(String id);
}
