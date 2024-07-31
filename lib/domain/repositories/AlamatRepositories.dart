import 'package:dekaybaro/domain/models/AlamatModel.dart';

abstract class AddressRepository {
  Future<List<Address>> getAddresses();
  Future<Address> getAddress(String id);
  Future<void> addAddress(Address address);
  Future<void> updateAddress(Address address);
  Future<void> deleteAddress(String id);
}
