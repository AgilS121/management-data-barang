import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/repositories/CartRepositories.dart';

class CartRepositoryImpl extends CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getCartItemsStream() {
    return _firestore.collection('cart').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          id: doc.id,
          name: data['name'],
          price: data['price'],
          image: List<String>.from(data['image']),
          stok: data['quantity'],
        );
      }).toList();
    });
  }

  @override
  Stream<List<Product>> getCartItemsStreamwhereuser(String userEmail) {
    return _firestore
        .collection('cart')
        .where('pembeli', isEqualTo: userEmail)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          id: doc.id,
          name: data['name'],
          price: data['price'],
          image: List<String>.from(data['image']),
          stok: data['quantity'],
        );
      }).toList();
    });
  }

  @override
  Future<void> addToCart(
      Product product, int quantity, String emailpembeli) async {
    try {
      await _firestore.collection('cart').doc(product.id).set({
        'name': product.name,
        'price': product.price,
        'image': product.image,
        'quantity': quantity,
        'pembeli': emailpembeli
      });
    } catch (e) {
      throw Exception('Failed to add product to cart');
    }
  }

  @override
  Future<void> removeFromCart(Product product) async {
    try {
      await _firestore.collection('cart').doc(product.id).delete();
    } catch (e) {
      throw Exception('Failed to remove product from cart');
    }
  }

  @override
  Future<void> updateCartItem(Product product, int quantity) async {
    try {
      await _firestore.collection('cart').doc(product.id).update({
        'quantity': quantity,
      });
    } catch (e) {
      throw Exception('Failed to update cart item');
    }
  }
}
