import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/repositories/AuthRepositories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._firebaseAuth, this._googleSignIn, this._firestore);

  @override
  Future<UserEntity?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        String docId = email.replaceAll('.', '_');

        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(docId).get();
        if (userDoc.exists) {
          return UserEntity(
              id: docId,
              email: user.email!,
              name: user.displayName ?? '',
              role: 'customers');
        }
      }
      return null;
    } catch (e) {
      print('Login error: $e');
      throw Exception('Failed to login: ${_handleAuthError(e)}');
    }
  }

  @override
  Future<UserEntity?> registerWithEmail(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        String docId = email.replaceAll('.', '_');

        await _firestore.collection('users').doc(docId).set({
          'uid': user.uid,
          'email': user.email,
          'name': name,
          'role': 'customers' // Default role
        });

        return UserEntity(
            id: docId,
            email: user.email!,
            name: name,
            role: 'customers'); // Default role
      }
      return null;
    } catch (e) {
      print('Registration error: $e');
      throw Exception('Failed to register: ${_handleAuthError(e)}');
    }
  }

  @override
  Future<UserEntity?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        String docId = user.email!.replaceAll('.', '_');

        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(docId).get();
        if (!userDoc.exists) {
          await _firestore.collection('users').doc(docId).set({
            'uid': user.uid,
            'email': user.email,
            'name': user.displayName ?? '',
            'role': 'customers' // Default role
          });
        }

        return UserEntity(
            id: docId,
            email: user.email!,
            name: user.displayName ?? '',
            role: userDoc['role'] ??
                'customers'); // Assumes role is saved in Firestore
      }
      return null;
    } catch (e) {
      print('Google login error: $e');
      throw Exception('Failed to login with Google: ${_handleAuthError(e)}');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  String _handleAuthError(dynamic e) {
    String message = 'An unknown error occurred';
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Wrong password provided.';
          break;
        case 'email-already-in-use':
          message = 'The email address is already in use by another account.';
          break;
        default:
          message = e.message ?? message;
      }
    }
    return message;
  }
}
