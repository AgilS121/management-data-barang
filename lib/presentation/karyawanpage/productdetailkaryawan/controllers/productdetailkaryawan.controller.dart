import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekaybaro/domain/entities/UserEntitites.dart';
import 'package:dekaybaro/domain/models/ProductModel.dart';
import 'package:dekaybaro/domain/usecase/CartUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductdetailkaryawanController extends GetxController {
  final GetCartItemsStream getCartItemsUseCase;
  final GetCartItemsStreamwhereuser getCartItemsStreamwhereuser;

  StreamSubscription<List<Product>>? _cartSubscription;

  ProductdetailkaryawanController({
    required this.getCartItemsUseCase,
    required this.getCartItemsStreamwhereuser,
  });

  final Rx<Product> product = Rx<Product>(Product(
    name: '',
    price: 0,
    image: [],
    adalahKayuGelondongan: false,
    jenisKayu: '',
    kualitas: '',
    deskripsi: '',
  ));
  final selectedImageIndex = 0.obs;
  final isFavorite = false.obs;
  final isAddingToCart = false.obs;
  final cartItemCount = 0.obs;
  final quantity = 1.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<UserEntity?> user = Rx<UserEntity?>(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadProductData();
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

  void _loadProductData() {
    var args = Get.arguments;
    if (args is Product) {
      product.value = args;
    } else {
      print('Error: Expected Product object as argument');
      product.value = Product(
        name: 'Unknown',
        price: 0,
        image: [],
        adalahKayuGelondongan: false,
        jenisKayu: 'Unknown',
        kualitas: 'Unknown',
        deskripsi: 'No description available',
      );
    }
  }

  void _subscribeToCartChanges() {
    final currentEmail = _auth.currentUser?.email ?? '';
    _cartSubscription =
        getCartItemsStreamwhereuser(currentEmail).listen((cartItems) {
      cartItemCount.value = cartItems.length;
    }, onError: (error) {
      print('Error listening to cart changes: $error');
    });
  }

  void selectImage(int index) {
    selectedImageIndex.value = index;
  }

  Future<void> remindToAddStock() async {
    isAddingToCart.value = true;
    try {
      // Implement the logic to remind about adding stock
      // For example, you might send a notification or update a database
      await _firestore.collection('stockReminders').add({
        'productId': product.value.id,
        'productName': product.value.name,
        'currentStock': product.value.stok,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      Get.snackbar('Success', 'Reminder sent to add more stock',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print('Error reminding to add stock: $e');
      Get.snackbar('Error', 'Failed to send reminder',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isAddingToCart.value = false;
    }
  }

  @override
  void onClose() {
    _cartSubscription?.cancel();
    super.onClose();
  }
}
