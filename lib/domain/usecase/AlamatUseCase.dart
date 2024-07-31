import 'package:dekaybaro/domain/models/AlamatModel.dart';
import 'package:dekaybaro/domain/repositories/AlamatRepositories.dart';

class GetAddresses {
  final AddressRepository repository;

  GetAddresses(this.repository);

  Future<List<Address>> call() => repository.getAddresses();
}

class GetAddress {
  final AddressRepository repository;

  GetAddress(this.repository);

  Future<Address> call(String id) => repository.getAddress(id);
}

class AddAddress {
  final AddressRepository repository;

  AddAddress(this.repository);

  Future<void> call(Address address) => repository.addAddress(address);
}

class UpdateAddress {
  final AddressRepository repository;

  UpdateAddress(this.repository);

  Future<void> call(Address address) => repository.updateAddress(address);
}

class DeleteAddress {
  final AddressRepository repository;

  DeleteAddress(this.repository);

  Future<void> call(String id) => repository.deleteAddress(id);
}
