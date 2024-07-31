import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/models/AlamatModel.dart';
import 'package:dekaybaro/domain/repositories/AlamatRepositories.dart';

class AddressRepositoryImpl implements AddressRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'addresses';

  @override
  Future<List<Address>> getAddresses() async {
    try {
      final querySnapshot = await _firestore.collection(_collection).get();
      return querySnapshot.docs
          .map((doc) => Address.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Failed to get addresses: $e');
    }
  }

  @override
  Future<Address> getAddress(String id) async {
    try {
      final docSnapshot =
          await _firestore.collection(_collection).doc(id).get();
      if (docSnapshot.exists) {
        return Address.fromJson(docSnapshot.data()!);
      } else {
        throw Exception('Address not found');
      }
    } catch (e) {
      throw Exception('Failed to get address: $e');
    }
  }

  @override
  Future<void> addAddress(Address address) async {
    try {
      await _firestore.collection(_collection).add(address.toJson());
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  @override
  Future<void> updateAddress(Address address) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(address.id)
          .update(address.toJson());
    } catch (e) {
      throw Exception('Failed to update address: $e');
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }
}
