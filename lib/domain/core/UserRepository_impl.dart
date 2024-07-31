import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/repositories/UserRepositories.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  UserRepositoryImpl(this._firebaseAuth, this._firestore);

  @override
  Future<UserEntity?> getCurrentUser() async {
    User? currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      String uid = currentUser.uid;
      String email = currentUser.email ?? '';

      try {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(email.replaceAll('.', '_'))
            .get();

        if (userDoc.exists) {
          return UserEntity(
            id: uid,
            email: email,
            name: userDoc['name'] ?? '',
            role: userDoc['role'] ?? 'customers',
          );
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
    return null;
  }
}
