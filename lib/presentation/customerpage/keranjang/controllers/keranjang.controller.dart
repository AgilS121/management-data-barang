import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/CartUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class KeranjangController extends GetxController {
  final GetCartItemsStream getCartItemsStream;
  final AddToCart addToCart;
  final RemoveFromCart removeFromCart;
  final UpdateCartItem updateCartItem;

  final RxList<Product> cartItems = <Product>[].obs;
  final RxBool isLoading = false.obs;

  StreamSubscription<List<Product>>? _cartSubscription;

  KeranjangController({
    required this.getCartItemsStream,
    required this.addToCart,
    required this.removeFromCart,
    required this.updateCartItem,
  });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<UserEntity?> user = Rx<UserEntity?>(null);

  @override
  void onInit() {
    super.onInit();
    _subscribeToCartChanges();
    loadUserData();
  }

  Future<void> loadUserData() async {
    isLoading.value = true;
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        String userId = currentUser.email ?? '';
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(userId).get();
        if (userDoc.exists) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          user.value = UserEntity(
            id: userId,
            email: userData['email'] ?? 'No Email',
            name: userData['name'] ?? 'No Name',
            role: userData['role'] ?? 'customers',
          );
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String get userName => user.value?.name ?? 'User';
  String get userEmail => user.value?.email ?? 'example@gmail.com';

  void _subscribeToCartChanges() {
    isLoading.value = true;
    _cartSubscription = getCartItemsStream().listen((updatedCartItems) {
      cartItems.value = updatedCartItems;
      isLoading.value = false;
    }, onError: (error) {
      print('Error listening to cart changes: $error');
      isLoading.value = false;
    });
  }

  Future<void> addToCartItem(Product product) async {
    try {
      await addToCart(product, 1, userEmail);
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }

  Future<void> increaseQuantity(Product product) async {
    final newQty = (product.stok ?? 0) + 1;
    try {
      await updateCartItem(product, newQty);
    } catch (e) {
      print('Error increasing quantity: $e');
    }
  }

  Future<void> decreaseQuantity(Product product) async {
    if ((product.stok ?? 0) > 1) {
      final newQty = (product.stok ?? 0) - 1;
      try {
        await updateCartItem(product, newQty);
      } catch (e) {
        print('Error decreasing quantity: $e');
      }
    } else {
      await removeItem(product);
    }
  }

  Future<void> removeItem(Product product) async {
    try {
      await removeFromCart(product);
    } catch (e) {
      print('Error removing item: $e');
    }
  }

  int getQuantity(Product product) {
    return product.stok ?? 0;
  }

  @override
  void onClose() {
    _cartSubscription?.cancel();
    super.onClose();
  }
}
