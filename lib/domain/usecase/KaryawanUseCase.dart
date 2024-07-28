import 'package:dartz/dartz.dart';
import 'package:dekaybaro/domain/models/KaryawanModel.dart';
import 'package:dekaybaro/domain/repositories/KaryawanRepositories.dart';

class AddKaryawan {
  final KaryawanRepositories repository;

  AddKaryawan(this.repository);

  Future<Either<Exception, KaryawanModel>> call(KaryawanModel karyawan) {
    return repository.addKaryawan(karyawan);
  }
}

class GetAllKaryawan {
  final KaryawanRepositories repository;

  GetAllKaryawan(this.repository);

  Future<Either<Exception, List<KaryawanModel>>> call() {
    return repository.getAllKaryawan();
  }
}

class UpdateKaryawan {
  final KaryawanRepositories repository;

  UpdateKaryawan(this.repository);

  Future<Either<Exception, KaryawanModel>> call(KaryawanModel product) {
    return repository.updateKaryawan(product);
  }
}

class DeleteKaryawan {
  final KaryawanRepositories repository;

  DeleteKaryawan(this.repository);

  Future<Either<Exception, void>> call(String id) {
    return repository.deleteKaryawan(id);
  }
}
