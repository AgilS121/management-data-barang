import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/repositories/CartRepositories.dart';

class CartRepositoryImpl extends CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Product>> getCartItems() async {
    try {
      final querySnapshot = await _firestore.collection('cart').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          id: doc.id,
          name: data['name'],
          price: data['price'],
          image: List<String>.from(data['image']),
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load cart items');
    }
  }

  @override
  Future<void> addToCart(Product product, int quantity) async {
    try {
      await _firestore.collection('cart').doc(product.id).set({
        'name': product.name,
        'price': product.price,
        'image': product.image,
        'quantity': quantity,
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
